import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class FullscreenImagePreview extends StatefulWidget {
  const FullscreenImagePreview({
    super.key,
    required this.nodeId,
    required this.images,
    this.initialIndex = 0,
  });

  final String nodeId;
  final List<NodeImage> images;
  final int initialIndex;

  @override
  State<FullscreenImagePreview> createState() => _FullscreenImagePreviewState();
}

class _FullscreenImagePreviewState extends State<FullscreenImagePreview> {
  late final PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sorted = [...widget.images]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('${_index + 1} of ${sorted.length}'),
        actions: [
          Semantics(
            button: true,
            label: 'Close image preview',
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
      body: PhotoViewGallery.builder(
        pageController: _controller,
        itemCount: sorted.length,
        onPageChanged: (index) => setState(() => _index = index),
        builder: (context, index) {
          final image = sorted[index];
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(image.url),
            heroAttributes: PhotoViewHeroAttributes(
              tag: 'node-image-${widget.nodeId}-${image.id}',
            ),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
          );
        },
      ),
    );
  }
}
