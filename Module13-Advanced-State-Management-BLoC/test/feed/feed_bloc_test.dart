import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_hub/features/feed/bloc/feed_bloc.dart';
import 'package:bloc_hub/features/feed/bloc/feed_event.dart';
import 'package:bloc_hub/features/feed/bloc/feed_state.dart';
import 'package:bloc_hub/features/feed/data/feed_repository.dart';
import 'package:bloc_hub/core/result.dart';
import 'package:bloc_hub/core/exceptions.dart';

/// Mock repository for testing
class MockFeedRepository extends Mock implements FeedRepository {}

/// Unit tests for FeedBloc
/// This demonstrates BLoC testing with async operations and pagination
void main() {
  group('FeedBloc', () {
    late FeedBloc feedBloc;
    late MockFeedRepository mockRepository;

    setUp(() {
      mockRepository = MockFeedRepository();
      feedBloc = FeedBloc(repository: mockRepository);
    });

    tearDown(() {
      feedBloc.close();
    });

    test('initial state is correct', () {
      expect(feedBloc.state, const FeedState.initial());
      expect(feedBloc.state.status, FeedStatus.initial);
      expect(feedBloc.state.items, isEmpty);
      expect(feedBloc.state.currentPage, 0);
      expect(feedBloc.state.hasReachedEnd, false);
      expect(feedBloc.state.errorMessage, isNull);
      expect(feedBloc.state.canLoadMore, true);
    });

    group('FeedFetchFirstPage', () {
      blocTest<FeedBloc, FeedState>(
        'emits [loading, success] when first page fetch succeeds',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => Result.success([
                    FeedItem(
                      id: '1',
                      title: 'Feed Item 1',
                      content: 'Content 1',
                      author: 'Author 1',
                    ),
                  ]));
          return feedBloc;
        },
        act: (bloc) => bloc.add(const FeedFetchFirstPage()),
        expect: () => [
          const FeedState.loading(),
          FeedState.success(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
            hasReachedEnd: false,
          ),
        ],
      );

      blocTest<FeedBloc, FeedState>(
        'emits [loading, success] with hasReachedEnd when no items returned',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => const Result.success([]));
          return feedBloc;
        },
        act: (bloc) => bloc.add(const FeedFetchFirstPage()),
        expect: () => [
          const FeedState.loading(),
          const FeedState.success(
            items: [],
            currentPage: 1,
            hasReachedEnd: true,
          ),
        ],
      );

      blocTest<FeedBloc, FeedState>(
        'emits [loading, failure] when first page fetch fails',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => const Result.error(
                    NetworkException('Network error'),
                  ));
          return feedBloc;
        },
        act: (bloc) => bloc.add(const FeedFetchFirstPage()),
        expect: () => [
          const FeedState.loading(),
          const FeedState.failure(errorMessage: 'NetworkException: Network error'),
        ],
      );

      blocTest<FeedBloc, FeedState>(
        'prevents duplicate requests when already loading',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => Result.success([
                    FeedItem(
                      id: '1',
                      title: 'Feed Item 1',
                      content: 'Content 1',
                      author: 'Author 1',
                    ),
                  ]));
          return feedBloc;
        },
        act: (bloc) {
          bloc.add(const FeedFetchFirstPage());
          bloc.add(const FeedFetchFirstPage()); // Should be ignored
        },
        expect: () => [
          const FeedState.loading(),
          FeedState.success(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
            hasReachedEnd: false,
          ),
        ],
      );
    });

    group('FeedFetchNextPage', () {
      blocTest<FeedBloc, FeedState>(
        'emits [moreLoading, success] when next page fetch succeeds',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => Result.success([
                    FeedItem(
                      id: '1',
                      title: 'Feed Item 1',
                      content: 'Content 1',
                      author: 'Author 1',
                    ),
                  ]));
          when(() => mockRepository.fetchFeed(2))
              .thenAnswer((_) async => Result.success([
                    FeedItem(
                      id: '2',
                      title: 'Feed Item 2',
                      content: 'Content 2',
                      author: 'Author 2',
                    ),
                  ]));
          return feedBloc;
        },
        act: (bloc) => bloc
          ..add(const FeedFetchFirstPage())
          ..add(const FeedFetchNextPage()),
        expect: () => [
          const FeedState.loading(),
          FeedState.success(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
            hasReachedEnd: false,
          ),
          FeedState.moreLoading(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
          ),
          FeedState.success(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
              FeedItem(
                id: '2',
                title: 'Feed Item 2',
                content: 'Content 2',
                author: 'Author 2',
              ),
            ],
            currentPage: 2,
            hasReachedEnd: false,
          ),
        ],
      );

      blocTest<FeedBloc, FeedState>(
        'emits [moreLoading, endReached] when no more items',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => Result.success([
                    FeedItem(
                      id: '1',
                      title: 'Feed Item 1',
                      content: 'Content 1',
                      author: 'Author 1',
                    ),
                  ]));
          when(() => mockRepository.fetchFeed(2))
              .thenAnswer((_) async => const Result.success([]));
          return feedBloc;
        },
        act: (bloc) => bloc
          ..add(const FeedFetchFirstPage())
          ..add(const FeedFetchNextPage()),
        expect: () => [
          const FeedState.loading(),
          FeedState.success(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
            hasReachedEnd: false,
          ),
          FeedState.moreLoading(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
          ),
          FeedState.endReached(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 2,
          ),
        ],
      );

      blocTest<FeedBloc, FeedState>(
        'emits [moreLoading, failure] when next page fetch fails',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => Result.success([
                    FeedItem(
                      id: '1',
                      title: 'Feed Item 1',
                      content: 'Content 1',
                      author: 'Author 1',
                    ),
                  ]));
          when(() => mockRepository.fetchFeed(2))
              .thenAnswer((_) async => const Result.error(
                    NetworkException('Network error'),
                  ));
          return feedBloc;
        },
        act: (bloc) => bloc
          ..add(const FeedFetchFirstPage())
          ..add(const FeedFetchNextPage()),
        expect: () => [
          const FeedState.loading(),
          FeedState.success(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
            hasReachedEnd: false,
          ),
          FeedState.moreLoading(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
          ),
          FeedState.failure(
            errorMessage: 'NetworkException: Network error',
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
          ),
        ],
      );

      blocTest<FeedBloc, FeedState>(
        'does not fetch next page when hasReachedEnd is true',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => const Result.success([]));
          return feedBloc;
        },
        act: (bloc) => bloc
          ..add(const FeedFetchFirstPage())
          ..add(const FeedFetchNextPage()),
        expect: () => [
          const FeedState.loading(),
          const FeedState.success(
            items: [],
            currentPage: 1,
            hasReachedEnd: true,
          ),
        ],
      );
    });

    group('FeedRefresh', () {
      blocTest<FeedBloc, FeedState>(
        'resets to initial state and fetches first page',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => Result.success([
                    FeedItem(
                      id: '1',
                      title: 'Feed Item 1',
                      content: 'Content 1',
                      author: 'Author 1',
                    ),
                  ]));
          return feedBloc;
        },
        act: (bloc) => bloc.add(const FeedRefresh()),
        expect: () => [
          const FeedState.initial(),
          const FeedState.loading(),
          FeedState.success(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
            hasReachedEnd: false,
          ),
        ],
      );
    });

    group('FeedRetry', () {
      blocTest<FeedBloc, FeedState>(
        'retries first page when no items exist',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => Result.success([
                    FeedItem(
                      id: '1',
                      title: 'Feed Item 1',
                      content: 'Content 1',
                      author: 'Author 1',
                    ),
                  ]));
          return feedBloc;
        },
        act: (bloc) => bloc.add(const FeedRetry()),
        expect: () => [
          const FeedState.loading(),
          FeedState.success(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
            hasReachedEnd: false,
          ),
        ],
      );

      blocTest<FeedBloc, FeedState>(
        'retries next page when items exist',
        build: () {
          when(() => mockRepository.fetchFeed(1))
              .thenAnswer((_) async => Result.success([
                    FeedItem(
                      id: '1',
                      title: 'Feed Item 1',
                      content: 'Content 1',
                      author: 'Author 1',
                    ),
                  ]));
          when(() => mockRepository.fetchFeed(2))
              .thenAnswer((_) async => Result.success([
                    FeedItem(
                      id: '2',
                      title: 'Feed Item 2',
                      content: 'Content 2',
                      author: 'Author 2',
                    ),
                  ]));
          return feedBloc;
        },
        act: (bloc) => bloc
          ..add(const FeedFetchFirstPage())
          ..add(const FeedRetry()),
        expect: () => [
          const FeedState.loading(),
          FeedState.success(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
            hasReachedEnd: false,
          ),
          FeedState.moreLoading(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
            ],
            currentPage: 1,
          ),
          FeedState.success(
            items: [
              FeedItem(
                id: '1',
                title: 'Feed Item 1',
                content: 'Content 1',
                author: 'Author 1',
              ),
              FeedItem(
                id: '2',
                title: 'Feed Item 2',
                content: 'Content 2',
                author: 'Author 2',
              ),
            ],
            currentPage: 2,
            hasReachedEnd: false,
          ),
        ],
      );
    });

    group('State properties', () {
      test('isEmpty returns true when no items', () {
        const state = FeedState();
        expect(state.isEmpty, true);
      });

      test('hasItems returns true when items exist', () {
        final state = FeedState(
          items: [
            FeedItem(
              id: '1',
              title: 'Test',
              content: 'Content',
              author: 'Author',
            ),
          ],
        );
        expect(state.hasItems, true);
      });

      test('isLoading returns true for loading status', () {
        const state = FeedState(status: FeedStatus.loading);
        expect(state.isLoading, true);
      });

      test('isLoadingMore returns true for moreLoading status', () {
        const state = FeedState(status: FeedStatus.moreLoading);
        expect(state.isLoadingMore, true);
      });

      test('hasError returns true for failure status', () {
        const state = FeedState(status: FeedStatus.failure);
        expect(state.hasError, true);
      });
    });
  });
}
