import 'package:bloc_test/bloc_test.dart';
import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wishes_repository/wishes_repository.dart';

class FakeWish extends Fake implements Wish {}

class MockWishesRepository extends Mock implements WishesRepository {}

void main() {
  final mockWishes = [
    Wish(id: 'id_1', title: 'title_1'),
    Wish(id: 'id_2', title: 'title_2'),
    Wish(id: 'id_3', title: 'title_3', isCompleted: true),
  ];

  group('ShowWishesBloc', () {
    late WishesRepository wishesRepository;

    setUpAll(() {
      registerFallbackValue(FakeWish());
    });

    setUp(() {
      wishesRepository = MockWishesRepository();
      when(
        () => wishesRepository.getWishes(),
      ).thenAnswer((_) => Stream.value(mockWishes));
      when(() => wishesRepository.saveWish(any())).thenAnswer((_) async {});
    });

    ShowWishesBloc createBloc() {
      return ShowWishesBloc(wishesRepository: wishesRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(createBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          createBloc().state,
          equals(const ShowWishesState()),
        );
      });
    });

    group('WishesSubscriptionRequested', () {
      blocTest<ShowWishesBloc, ShowWishesState>(
        'starts listening to repository getWishes stream',
        build: createBloc,
        act: (bloc) => bloc.add(const WishesSubscriptionRequested()),
        verify: (_) {
          verify(() => wishesRepository.getWishes()).called(1);
        },
      );

      blocTest<ShowWishesBloc, ShowWishesState>(
        'emits state with updated status and wishes '
        'when repository getWishes stream emits new wishes',
        build: createBloc,
        act: (bloc) => bloc.add(const WishesSubscriptionRequested()),
        expect: () => [
          const ShowWishesState(
            status: ShowWishesStatus.loading,
          ),
          ShowWishesState(
            status: ShowWishesStatus.success,
            wishes: mockWishes,
          ),
        ],
      );

      blocTest<ShowWishesBloc, ShowWishesState>(
        'emits state with failure status '
        'when repository getWishes stream emits error',
        setUp: () {
          when(
            () => wishesRepository.getWishes(),
          ).thenAnswer((_) => Stream.error(Exception('oops')));
        },
        build: createBloc,
        act: (bloc) => bloc.add(const WishesSubscriptionRequested()),
        expect: () => [
          const ShowWishesState(status: ShowWishesStatus.loading),
          const ShowWishesState(status: ShowWishesStatus.failure),
        ],
      );
    });

    group('WishCompletionToggled', () {
      blocTest<ShowWishesBloc, ShowWishesState>(
        'saves wish with isCompleted set to event isCompleted flag',
        build: createBloc,
        seed: () => ShowWishesState(wishes: mockWishes),
        act: (bloc) => bloc.add(
          WishCompletionToggled(
            wish: mockWishes.first,
            isCompleted: true,
          ),
        ),
        verify: (_) {
          verify(
            () => wishesRepository
                .saveWish(mockWishes.first.copyWith(isCompleted: true)),
          ).called(1);
        },
      );
    });
  });
}
