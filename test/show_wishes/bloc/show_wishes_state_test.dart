// ignore_for_file: avoid_redundant_argument_values

import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wishes_repository/wishes_repository.dart';

void main() {
  final mockWishes = [Wish(id: 'id_1', title: 'title_1')];

  group('ShowWishesState', () {
    ShowWishesState createStateMock({
      ShowWishesStatus status = ShowWishesStatus.initial,
      List<Wish>? wishes,
      WishesViewFilter filter = WishesViewFilter.activeOnly,
    }) {
      return ShowWishesState(
        status: status,
        wishes: wishes ?? mockWishes,
        filter: filter,
      );
    }

    test('supports value equality', () {
      expect(
        createStateMock(),
        equals(createStateMock()),
      );
    });

    test('filteredWishes returns filtered wishes', () {
      expect(
        createStateMock(
          wishes: mockWishes,
          filter: WishesViewFilter.completedOnly,
        ).filteredWishes,
        equals(mockWishes.where((wish) => wish.isCompleted).toList()),
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
            status: null,
            wishes: null,
            filter: null,
          ),
          equals(createStateMock()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createStateMock().copyWith(
            status: () => ShowWishesStatus.success,
            wishes: () => [],
            filter: () => WishesViewFilter.completedOnly,
          ),
          equals(
            createStateMock(
              status: ShowWishesStatus.success,
              wishes: [],
              filter: WishesViewFilter.completedOnly,
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
          filter: WishesViewFilter.completedOnly,
        ).props,
        equals(<Object?>[
          ShowWishesStatus.success,
          mockWishes,
          WishesViewFilter.completedOnly,
        ]),
      );
    });
  });
}
