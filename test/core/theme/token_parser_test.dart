import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/core/theme/token_parser.dart';

void main() {
  test('parses local design token file', () {
    final json =
        jsonDecode(File('.specify/design-token.json').readAsStringSync())
            as Map<String, dynamic>;
    final tokens = const TokenParser().parse(json);

    expect(tokens.brandName, 'Keeply');
    expect(tokens.colors.primary.toARGB32(), 0xFF22C55E);
    expect(tokens.components.buttonHeight, 56);
  });
}
