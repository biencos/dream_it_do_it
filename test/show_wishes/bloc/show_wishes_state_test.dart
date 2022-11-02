import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wishes_repository/wishes_repository.dart';

void main() {
  final mockWishes = [Wish(id: 'id_1', title: 'title_1')];

  group('ShowWishesState', () {
    ShowWishesState createStateMock({
      ShowWishesStatus status = ShowWishesStatus.initial,
      List<Wish>? wishes,
    }) {
      return ShowWishesState(
        status: status,
        wishes: wishes ?? mockWishes,
      );
    }

    test('supports value equality', () {
      expect(
        createStateMock(),
        equals(createStateMock()),
      );
    });

    group('copyWith', () {
      test('returns the same object if no arguments are provided', () {
        expect(
          createStateMock().copyWith(),
          equals(createStateMock()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createStateMock().copyWith(
            // ignore: avoid_redundant_argument_values
            status: null,
            // ignore: avoid_redundant_argument_values
            wishes: null,
          ),
          equals(createStateMock()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createStateMock().copyWith(
            status: () => ShowWishesStatus.success,
            wishes: () => [],
          ),
          equals(
            createStateMock(
              status: ShowWishesStatus.success,
              wishes: [],
            ),
          ),
        );
      });
    });

    test('props works correctly', () {
      expect(
        createStateMock(
          status: ShowWishesStatus.success,
          wishes: mockWishes,
        ).props,
        equals(<Object?>[
          ShowWishesStatus.success,
          mockWishes,
        ]),
      );
    });
  });
}
