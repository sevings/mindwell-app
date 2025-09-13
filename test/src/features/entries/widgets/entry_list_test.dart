import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/widgets/entry_list.dart';

void main() {
  group('EntryList', () {
    test('can be instantiated with different feed types', () {
      // Test that the widget can be created with different feed types
      expect(() => EntryList(feedType: FeedType.live), returnsNormally);
      expect(() => EntryList(feedType: FeedType.best), returnsNormally);
      expect(() => EntryList(feedType: FeedType.friends), returnsNormally);
      expect(() => EntryList(feedType: FeedType.profile), returnsNormally);
      expect(() => EntryList(feedType: FeedType.theme), returnsNormally);
    });

    test('can be instantiated with feed parameter', () {
      // Test that the widget can be created with feed parameter
      expect(() => EntryList(
        feedType: FeedType.profile,
        feedParameter: 'user123',
      ), returnsNormally);
    });

    test('can be instantiated with different options', () {
      // Test that the widget can be created with different options
      expect(() => EntryList(
        feedType: FeedType.live,
        enablePullToRefresh: false,
      ), returnsNormally);

      expect(() => EntryList(
        feedType: FeedType.live,
        enableInfiniteScroll: false,
      ), returnsNormally);

      expect(() => EntryList(
        feedType: FeedType.live,
        loadMoreThreshold: 5,
      ), returnsNormally);
    });

    test('has correct default values', () {
      // Test that the widget has correct default values
      final widget = EntryList(feedType: FeedType.live);
      expect(widget.feedType, equals(FeedType.live));
      expect(widget.feedParameter, isNull);
      expect(widget.enablePullToRefresh, isTrue);
      expect(widget.enableInfiniteScroll, isTrue);
      expect(widget.loadMoreThreshold, equals(3));
    });
  });
}