// ignore_for_file: avoid_redundant_argument_values

import 'package:dream_it_do_it/add_wish/add_wish.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddWishState', () {
    AddWishState createStateMock({
      AddWishStatus status = AddWishStatus.initial,
      String title = '',
    }) {
      return AddWishState(
        status: status,
        title: title,
      );
    }

    test('supports value equality', () {
      expect(
        createStateMock(),
        equals(createStateMock()),
      );
    });

    test('props works correctly', () {
      expect(
        createStateMock(status: AddWishStatus.initial, title: 'title').props,
        equals(<Object?>[AddWishStatus.initial, 'title']),
      );
    });

    group('copyWith', () {
      test('returns the same object if no arguments are provided', () {
        expect(
          createStateMock().copyWith(),
          equals(createStateMock()),
        );
      });

      test('retains the old value for every argument if null is provided', () {
        expect(
          createStateMock().copyWith(status: null, title: null),
          equals(createStateMock()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createStateMock().copyWith(
            status: AddWishStatus.success,
            title: 'title',
          ),
          equals(
            createStateMock(status: AddWishStatus.success, title: 'title'),
          ),
        );
      });
    });
  });
}
