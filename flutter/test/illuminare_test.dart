import 'package:flutter_test/flutter_test.dart';

import 'package:illuminare/illuminare.dart';

void main() {
  test('Test illuminare can be initialized', () async {
    await Illuminare.initialize();

    expect(Illuminare.instance, isNotNull);
  });
}
