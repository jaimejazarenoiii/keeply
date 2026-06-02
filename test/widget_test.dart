import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/core/theme/design_tokens.dart';

void main() {
  test('fallback design tokens expose Keeply brand', () {
    final tokens = DesignTokens.fallback();

    expect(tokens.brandName, 'Keeply');
    expect(tokens.colors.primary.toARGB32(), 0xFF22C55E);
  });
}
