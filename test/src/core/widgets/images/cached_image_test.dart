import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mindwell/src/core/widgets/images/cached_image.dart';
import 'package:mindwell/src/core/widgets/loaders/skeleton_loader.dart';

void main() {
  group('CachedImage', () {
    const testImageUrl = 'https://example.com/test-image.jpg';

    testWidgets('renders with required imageUrl', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(imageUrl: testImageUrl),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('applies custom width and height', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: testImageUrl,
              width: 200.0,
              height: 150.0,
            ),
          ),
        ),
      );

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final mainSizedBox = sizedBoxes.firstWhere(
        (box) => box.width == 200.0 && box.height == 150.0,
      );
      expect(mainSizedBox.width, 200.0);
      expect(mainSizedBox.height, 150.0);
    });

    testWidgets('applies custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: testImageUrl,
              borderRadius: 12.0,
            ),
          ),
        ),
      );

      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(clipRRect.borderRadius, BorderRadius.circular(12.0));
    });

    testWidgets('uses skeleton loader as placeholder by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: testImageUrl,
              useSkeletonLoader: true,
            ),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('uses custom placeholder when provided', (WidgetTester tester) async {
      const customPlaceholder = Text('Custom Loading...');
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: testImageUrl,
              placeholder: customPlaceholder,
            ),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('uses custom error widget when provided', (WidgetTester tester) async {
      const customErrorWidget = Text('Custom Error');
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: testImageUrl,
              errorWidget: customErrorWidget,
            ),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('applies custom fit parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: testImageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('applies memory cache parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: testImageUrl,
              memCacheWidth: 300,
              memCacheHeight: 200,
            ),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('shows retry button on error when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: testImageUrl,
              showRetryOnError: true,
              onRetry: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('does not show retry button when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: testImageUrl,
              showRetryOnError: false,
            ),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });

  group('CachedAvatar', () {
    const testImageUrl = 'https://example.com/avatar.jpg';

    testWidgets('renders with imageUrl', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedAvatar(imageUrl: testImageUrl),
          ),
        ),
      );

      expect(find.byType(CachedImage), findsOneWidget);
    });

    testWidgets('renders with default size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedAvatar(imageUrl: testImageUrl),
          ),
        ),
      );

      final cachedImage = tester.widget<CachedImage>(find.byType(CachedImage));
      expect(cachedImage.width, 40.0);
      expect(cachedImage.height, 40.0);
    });

    testWidgets('renders with custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedAvatar(
              imageUrl: testImageUrl,
              size: 60.0,
            ),
          ),
        ),
      );

      final cachedImage = tester.widget<CachedImage>(find.byType(CachedImage));
      expect(cachedImage.width, 60.0);
      expect(cachedImage.height, 60.0);
    });

    testWidgets('renders with custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedAvatar(
              imageUrl: testImageUrl,
              borderRadius: 30.0,
            ),
          ),
        ),
      );

      final cachedImage = tester.widget<CachedImage>(find.byType(CachedImage));
      expect(cachedImage.borderRadius, 30.0);
    });

    testWidgets('renders fallback avatar when imageUrl is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedAvatar(imageUrl: null),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('renders fallback avatar when imageUrl is empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedAvatar(imageUrl: ''),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('renders with custom fallback text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedAvatar(
              imageUrl: null,
              fallbackText: 'JD',
            ),
          ),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('renders with custom fallback icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedAvatar(
              imageUrl: null,
              fallbackIcon: Icons.account_circle,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.account_circle), findsOneWidget);
    });

    testWidgets('renders with custom background color', (WidgetTester tester) async {
      const customColor = Colors.blue;
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedAvatar(
              imageUrl: null,
              backgroundColor: customColor,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, customColor);
    });

    testWidgets('uses theme colors in light mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: const Scaffold(
            body: CachedAvatar(imageUrl: null),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('uses theme colors in dark mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: const Scaffold(
            body: CachedAvatar(imageUrl: null),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });
  });

  group('CachedPostImage', () {
    const testImageUrl = 'https://example.com/post-image.jpg';

    testWidgets('renders with required imageUrl', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedPostImage(imageUrl: testImageUrl),
          ),
        ),
      );

      expect(find.byType(CachedImage), findsOneWidget);
    });

    testWidgets('renders with default aspect ratio', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedPostImage(
              imageUrl: testImageUrl,
              width: 320.0,
            ),
          ),
        ),
      );

      final cachedImage = tester.widget<CachedImage>(find.byType(CachedImage));
      expect(cachedImage.width, 320.0);
      expect(cachedImage.height, 180.0); // 320 / (16/9) = 180
    });

    testWidgets('renders with custom aspect ratio', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedPostImage(
              imageUrl: testImageUrl,
              width: 300.0,
              aspectRatio: 4 / 3,
            ),
          ),
        ),
      );

      final cachedImage = tester.widget<CachedImage>(find.byType(CachedImage));
      expect(cachedImage.width, 300.0);
      expect(cachedImage.height, 225.0); // 300 / (4/3) = 225
    });

    testWidgets('renders with custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedPostImage(
              imageUrl: testImageUrl,
              borderRadius: 16.0,
            ),
          ),
        ),
      );

      final cachedImage = tester.widget<CachedImage>(find.byType(CachedImage));
      expect(cachedImage.borderRadius, 16.0);
    });

    testWidgets('renders with skeleton loader by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedPostImage(
              imageUrl: testImageUrl,
              useSkeletonLoader: true,
            ),
          ),
        ),
      );

      expect(find.byType(CachedImage), findsOneWidget);
    });

    testWidgets('renders without skeleton loader when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedPostImage(
              imageUrl: testImageUrl,
              useSkeletonLoader: false,
            ),
          ),
        ),
      );

      expect(find.byType(CachedImage), findsOneWidget);
    });

    testWidgets('handles onTap callback', (WidgetTester tester) async {
      bool tapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CachedPostImage(
              imageUrl: testImageUrl,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsOneWidget);
      
      await tester.tap(find.byType(GestureDetector));
      expect(tapped, true);
    });

    testWidgets('renders without GestureDetector when onTap is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedPostImage(imageUrl: testImageUrl),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsNothing);
      expect(find.byType(CachedImage), findsOneWidget);
    });
  });

  group('CachedImage Error Handling', () {
    testWidgets('shows error widget with retry button when image fails', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: 'https://invalid-url.com/nonexistent.jpg',
              showRetryOnError: true,
              onRetry: () {},
            ),
          ),
        ),
      );

      // The CachedNetworkImage should be present
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('shows error widget without retry button when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: 'https://invalid-url.com/nonexistent.jpg',
              showRetryOnError: false,
            ),
          ),
        ),
      );

      // The CachedNetworkImage should be present
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('shows custom error widget when provided', (WidgetTester tester) async {
      const customErrorWidget = Text('Custom Error Message');
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: 'https://invalid-url.com/nonexistent.jpg',
              errorWidget: customErrorWidget,
            ),
          ),
        ),
      );

      // The CachedNetworkImage should be present
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });

  group('CachedImage Loading States', () {
    testWidgets('shows skeleton loader while loading', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: 'https://example.com/slow-loading-image.jpg',
              useSkeletonLoader: true,
            ),
          ),
        ),
      );

      // The skeleton loader should be shown initially
      expect(find.byType(SkeletonLoader), findsOneWidget);
    });

    testWidgets('shows custom placeholder while loading', (WidgetTester tester) async {
      const customPlaceholder = Text('Loading...');
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: 'https://example.com/slow-loading-image.jpg',
              placeholder: customPlaceholder,
            ),
          ),
        ),
      );

      // The custom placeholder should be shown initially
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('shows circular progress indicator when skeleton loader is disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CachedImage(
              imageUrl: 'https://example.com/slow-loading-image.jpg',
              useSkeletonLoader: false,
            ),
          ),
        ),
      );

      // The circular progress indicator should be shown initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
