import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/core/widgets/buttons/button_size.dart';

void main() {
  group('ButtonSize', () {
    group('height', () {
      test('returns correct height for small button', () {
        expect(ButtonSize.small.height, 32.0);
      });

      test('returns correct height for medium button', () {
        expect(ButtonSize.medium.height, 40.0);
      });

      test('returns correct height for large button', () {
        expect(ButtonSize.large.height, 48.0);
      });
    });

    group('horizontalPadding', () {
      test('returns correct horizontal padding for small button', () {
        expect(ButtonSize.small.horizontalPadding, 12.0);
      });

      test('returns correct horizontal padding for medium button', () {
        expect(ButtonSize.medium.horizontalPadding, 16.0);
      });

      test('returns correct horizontal padding for large button', () {
        expect(ButtonSize.large.horizontalPadding, 20.0);
      });
    });

    group('verticalPadding', () {
      test('returns correct vertical padding for small button', () {
        expect(ButtonSize.small.verticalPadding, 6.0);
      });

      test('returns correct vertical padding for medium button', () {
        expect(ButtonSize.medium.verticalPadding, 8.0);
      });

      test('returns correct vertical padding for large button', () {
        expect(ButtonSize.large.verticalPadding, 12.0);
      });
    });

    group('iconSize', () {
      test('returns correct icon size for small button', () {
        expect(ButtonSize.small.iconSize, 16.0);
      });

      test('returns correct icon size for medium button', () {
        expect(ButtonSize.medium.iconSize, 20.0);
      });

      test('returns correct icon size for large button', () {
        expect(ButtonSize.large.iconSize, 24.0);
      });
    });

    group('fontSize', () {
      test('returns correct font size for small button', () {
        expect(ButtonSize.small.fontSize, 12.0);
      });

      test('returns correct font size for medium button', () {
        expect(ButtonSize.medium.fontSize, 14.0);
      });

      test('returns correct font size for large button', () {
        expect(ButtonSize.large.fontSize, 16.0);
      });
    });
  });
}
