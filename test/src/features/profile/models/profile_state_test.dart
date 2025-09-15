import 'package:flutter_test/flutter_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:mindwell/src/features/profile/models/profile_state.dart';

void main() {
  group('ProfileState', () {
    late $MwProfile mockUser;
    late MwBadge mockBadge;
    late MwImage mockImage;
    late MwTagListDataInner mockTag;
    late MwCalendar mockCalendar;

    setUp(() {
      mockUser = $MwProfile((b) => b
        ..id = 1
        ..name = 'testuser'
        ..showName = 'Test User'
        ..isTheme = false
        ..isOnline = true
        ..avatar = MwAvatar((b) => b
          ..x124 = 'https://example.com/avatar_124.jpg'
          ..x92 = 'https://example.com/avatar_92.jpg'
          ..x42 = 'https://example.com/avatar_42.jpg'
        ).toBuilder()
      );

      mockBadge = MwBadge((b) => b
        ..code = 'first_entry'
        ..title = 'First Entry'
        ..description = 'Created your first entry'
        ..icon = 'star'
        ..level = 1
        ..givenAt = 1234567890.0
      );

      mockImage = MwImage((b) => b
        ..id = 1
        ..author = mockUser
        ..isAnimated = false
        ..processing = false
        ..thumbnail = MwImageSize((b) => b
          ..width = 150
          ..height = 150
          ..url = 'https://example.com/thumb.jpg'
        ).toBuilder()
        ..small = MwImageSize((b) => b
          ..width = 300
          ..height = 300
          ..url = 'https://example.com/small.jpg'
        ).toBuilder()
        ..medium = MwImageSize((b) => b
          ..width = 600
          ..height = 600
          ..url = 'https://example.com/medium.jpg'
        ).toBuilder()
        ..large = MwImageSize((b) => b
          ..width = 1200
          ..height = 1200
          ..url = 'https://example.com/large.jpg'
        ).toBuilder()
      );

      mockTag = MwTagListDataInner((b) => b
        ..tag = 'mindfulness'
        ..count = 5
      );

      mockCalendar = MwCalendar((b) => b
        ..entries = ListBuilder<MwCalendarEntry>([
          MwCalendarEntry((b) => b
            ..id = 1
            ..createdAt = 1234567890.0
            ..title = 'Test Entry'
          )
        ])
        ..start = 1234567890.0
        ..end = 1234654290.0
        ..limit = 30
      );
    });

    test('should create initial state', () {
      const state = ProfileState.initial();

      expect(state, isA<ProfileState>());
    });

    test('should create loading state', () {
      const state = ProfileState.loading();

      expect(state, isA<ProfileState>());
    });

    test('should create loaded state with required user parameter', () {
      final state = ProfileState.loaded(
        user: mockUser,
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) {
          expect(user, mockUser);
          expect(badges, isEmpty);
          expect(images, isEmpty);
          expect(tags, isEmpty);
          expect(calendarData, isNull);
          expect(entries, isEmpty);
          expect(hasMoreEntries, false);
        },
        error: (message) => fail('Expected loaded state'),
      );
    });

    test('should create loaded state with all parameters', () {
      final state = ProfileState.loaded(
        user: mockUser,
        badges: [mockBadge],
        images: [mockImage],
        tags: [mockTag],
        calendarData: mockCalendar,
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) {
          expect(user, mockUser);
          expect(badges, [mockBadge]);
          expect(images, [mockImage]);
          expect(tags, [mockTag]);
          expect(calendarData, mockCalendar);
          expect(entries, isEmpty);
          expect(hasMoreEntries, false);
        },
        error: (message) => fail('Expected loaded state'),
      );
    });

    test('should create loaded state with partial data', () {
      final state = ProfileState.loaded(
        user: mockUser,
        badges: [mockBadge],
        images: [mockImage],
        // tags and calendarData left as defaults
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) {
          expect(user, mockUser);
          expect(badges, [mockBadge]);
          expect(images, [mockImage]);
          expect(tags, isEmpty);
          expect(calendarData, isNull);
          expect(entries, isEmpty);
          expect(hasMoreEntries, false);
        },
        error: (message) => fail('Expected loaded state'),
      );
    });

    test('should create error state with message', () {
      const state = ProfileState.error(
        message: 'Failed to load profile',
      );

      state.when(
        initial: () => fail('Expected error state'),
        loading: () => fail('Expected error state'),
        loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) => fail('Expected error state'),
        error: (message) {
          expect(message, 'Failed to load profile');
        },
      );
    });

    test('should be immutable', () {
      final state1 = ProfileState.loaded(
        user: mockUser,
        badges: [mockBadge],
      );
      final state2 = ProfileState.loaded(
        user: mockUser,
        badges: [mockBadge],
      );

      expect(state1, equals(state2));
      expect(state1.hashCode, equals(state2.hashCode));
    });

    test('should support pattern matching', () {
      const loadingState = ProfileState.loading();
      const errorState = ProfileState.error(message: 'Test error');

      expect(
        loadingState.when(
          initial: () => 'initial',
          loading: () => 'loading',
          loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) => 'loaded',
          error: (message) => 'error',
        ),
        'loading',
      );

      expect(
        errorState.when(
          initial: () => 'initial',
          loading: () => 'loading',
          loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) => 'loaded',
          error: (message) => 'error',
        ),
        'error',
      );
    });

    test('should support maybeWhen', () {
      const loadingState = ProfileState.loading();

      final result = loadingState.maybeWhen(
        loading: () => 'loading',
        orElse: () => 'other',
      );

      expect(result, 'loading');
    });

    test('should support map', () {
      final loadedState = ProfileState.loaded(
        user: mockUser,
        badges: [mockBadge],
      );

      final result = loadedState.map(
        initial: (state) => 'initial',
        loading: (state) => 'loading',
        loaded: (state) => 'loaded: ${state.badges.length} badges',
        error: (state) => 'error: ${state.message}',
      );

      expect(result, 'loaded: 1 badges');
    });

    test('should handle multiple badges in loaded state', () {
      final badge2 = MwBadge((b) => b
        ..code = 'week_streak'
        ..title = 'Week Streak'
        ..description = 'Posted for 7 days in a row'
        ..icon = 'flame'
        ..level = 2
        ..givenAt = 1234567891.0
      );

      final state = ProfileState.loaded(
        user: mockUser,
        badges: [mockBadge, badge2],
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) {
          expect(badges, hasLength(2));
          expect(badges, [mockBadge, badge2]);
          expect(entries, isEmpty);
          expect(hasMoreEntries, false);
        },
        error: (message) => fail('Expected loaded state'),
      );
    });

    test('should handle multiple images in loaded state', () {
      final image2 = MwImage((b) => b
        ..id = 2
        ..author = mockUser
        ..isAnimated = false
        ..processing = false
        ..thumbnail = MwImageSize((b) => b
          ..width = 150
          ..height = 150
          ..url = 'https://example.com/thumb2.jpg'
        ).toBuilder()
        ..small = MwImageSize((b) => b
          ..width = 300
          ..height = 300
          ..url = 'https://example.com/small2.jpg'
        ).toBuilder()
        ..medium = MwImageSize((b) => b
          ..width = 600
          ..height = 600
          ..url = 'https://example.com/medium2.jpg'
        ).toBuilder()
        ..large = MwImageSize((b) => b
          ..width = 1200
          ..height = 1200
          ..url = 'https://example.com/large2.jpg'
        ).toBuilder()
      );

      final state = ProfileState.loaded(
        user: mockUser,
        images: [mockImage, image2],
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) {
          expect(images, hasLength(2));
          expect(images, [mockImage, image2]);
          expect(entries, isEmpty);
          expect(hasMoreEntries, false);
        },
        error: (message) => fail('Expected loaded state'),
      );
    });

    test('should handle multiple tags in loaded state', () {
      final tag2 = MwTagListDataInner((b) => b
        ..tag = 'gratitude'
        ..count = 3
      );

      final state = ProfileState.loaded(
        user: mockUser,
        tags: [mockTag, tag2],
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) {
          expect(tags, hasLength(2));
          expect(tags, [mockTag, tag2]);
          expect(entries, isEmpty);
          expect(hasMoreEntries, false);
        },
        error: (message) => fail('Expected loaded state'),
      );
    });

    test('should handle calendar data in loaded state', () {
      final state = ProfileState.loaded(
        user: mockUser,
        calendarData: mockCalendar,
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) {
          expect(calendarData, mockCalendar);
          expect(calendarData?.entries, isNotNull);
          expect(calendarData?.entries?.length, 1);
          expect(entries, isEmpty);
          expect(hasMoreEntries, false);
        },
        error: (message) => fail('Expected loaded state'),
      );
    });
  });
}
