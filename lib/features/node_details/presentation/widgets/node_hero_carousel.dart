import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_details_responsive_container.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class NodeHeroCarousel extends StatefulWidget {
  const NodeHeroCarousel({
    super.key,
    required this.node,
    required this.placeholderIcon,
    this.onImageTap,
  });

  final StorageNode node;
  final IconData placeholderIcon;
  final void Function(int index)? onImageTap;

  @override
  State<NodeHeroCarousel> createState() => _NodeHeroCarouselState();
}

class _NodeHeroCarouselState extends State<NodeHeroCarousel> {
  final _controller = PageController();
  var _index = 0;

  List<NodeImage> get _images {
    final sorted = [...widget.node.images]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return sorted;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = nodeCarouselHeight(context);
    final colors = AppTheme.tokens.colors;
    final spacing = AppTheme.tokens.spacing;

    if (_images.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(bottom: spacing.sm),
        child: Semantics(
          label: 'No photos added, ${widget.node.type.name}',
          child: NodeCarouselThumbnailFrame(
            height: height,
            child: ColoredBox(
              color: colors.secondary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No photos yet',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Semantics(
      label: 'Image ${_index + 1} of ${_images.length}',
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: spacing.sm),
            child: NodeCarouselThumbnailFrame(
              height: height,
              child: PageView.builder(
                controller: _controller,
                itemCount: _images.length,
                onPageChanged: (value) => setState(() => _index = value),
                itemBuilder: (context, index) {
                  final image = _images[index];
                  return GestureDetector(
                    onTap: () => widget.onImageTap?.call(index),
                    child: Hero(
                      tag: 'node-image-${widget.node.id}-${image.id}',
                      child: CachedNetworkImage(
                        imageUrl: image.url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: height,
                        placeholder: (_, __) => Image.asset(
                          kDashboardNodePlaceholder,
                          fit: BoxFit.cover,
                          height: height,
                          width: double.infinity,
                        ),
                        errorWidget: (_, __, ___) => Image.asset(
                          kDashboardNodePlaceholder,
                          fit: BoxFit.cover,
                          height: height,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (_images.length > 1) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _images.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _index ? colors.primary : colors.border,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class NodeCarouselThumbnailFrame extends StatelessWidget {
  const NodeCarouselThumbnailFrame({
    super.key,
    required this.height,
    required this.child,
  });

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderRadius = nodeCarouselBorderRadius();

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: nodeCarouselThumbnailShadow(),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}
