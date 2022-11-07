import 'package:bloc_test/bloc_test.dart';
import 'package:dream_it_do_it/add_wish/add_wish.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wishes_repository/wishes_repository.dart';

class FakeWish extends Fake implements Wish {}

class MockWishesRepository extends Mock implements WishesRepository {}

void main() {
  group('AddWishBloc', () {
    late WishesRepository wishesRepository;

    setUpAll(() {
      registerFallbackValue(FakeWish());
    });

    setUp(() {
      wishesRepository = MockWishesRepository();
    });

    AddWishBloc buildBloc() {
      return AddWishBloc(wishesRepository: wishesRepository);
    }

    group('constructor', () {
      test('works properly', () {
        expect(buildBloc, returnsNormally);
      });

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const AddWishState()),
        );
      });
    });

    group('AddWishTitleChanged', () {
      blocTest<AddWishBloc, AddWishState>(
        'emits new state with updated title',
        build: buildBloc,
        act: (bloc) => bloc.add(const AddWishTitleChanged('new_title')),
        expect: () => const [AddWishState(title: 'new_title')],
      );
    });

    group('AddWishSubmitted', () {
      blocTest<AddWishBloc, AddWishState>(
        'attempts to save new wish to repository ',
        setUp: () {
          when(() => wishesRepository.saveWish(any())).thenAnswer((_) async {});
        },
        build: buildBloc,
        seed: () => const AddWishState(title: 'title_1'),
        act: (bloc) => bloc.add(const AddWishSubmitted()),
        expect: () => const [
          AddWishState(status: AddWishStatus.loading, title: 'title_1'),
          AddWishState(status: AddWishStatus.success, title: 'title_1'),
        ],
        verify: (bloc) {
          verify(
            () => wishesRepository.saveWish(
              any(
                that: isA<Wish>()
                    .having((t) => t.title, 'title_1', equals('title_1')),
              ),
            ),
          ).called(1);
        },
      );

      blocTest<AddWishBloc, AddWishState>(
        'emits new state with error if save to repository fails',
        build: () {
          when(() => wishesRepository.saveWish(any()))
              .thenThrow(Exception('SaveFailedException'));
          return buildBloc();
        },
        seed: () => const AddWishState(title: 'title_1'),
        act: (bloc) => bloc.add(const AddWishSubmitted()),
        expect: () => const [
          AddWishState(status: AddWishStatus.loading, title: 'title_1'),
          AddWishState(status: AddWishStatus.failure, title: 'title_1'),
        ],
      );
    });
  });
}
