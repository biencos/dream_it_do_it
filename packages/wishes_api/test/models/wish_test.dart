import 'package:test/test.dart';
import 'package:wishes_api/wishes_api.dart';

void main() {
  group('Wish', () {
    Wish createWishMock({
      String? id = 'id',
      String title = 'title',
      bool isCompleted = true,
    }) {
      return Wish(
        id: id,
        title: title,
        isCompleted: isCompleted,
      );
    }

    test('constructor works correctly', () {
      expect(
        createWishMock,
        returnsNormally,
      );
    });

    test('fromJson works correctly', () {
      expect(
        Wish.fromJson(<String, dynamic>{
          'id': 'id',
          'title': 'title',
          'isCompleted': true,
        }),
        equals(createWishMock()),
      );
    });

    test('toJson works correctly', () {
      expect(
        createWishMock().toJson(),
        equals(
          <String, dynamic>{
            'id': 'id',
            'title': 'title',
            'isCompleted': true,
          },
        ),
      );
    });

    group('copyWith', () {
      test('returns the same object when there is no arguments', () {
        expect(
          createWishMock().copyWith(),
          equals(createWishMock()),
        );
      });

      test('replaces every non-null argument', () {
        expect(
          createWishMock().copyWith(
            id: 'new id',
            title: 'new title',
            isCompleted: false,
          ),
          equals(
            createWishMock(
              id: 'new id',
              title: 'new title',
              isCompleted: false,
            ),
          ),
        );
      });
    });

    test('props works correctly', () {
      expect(
        createWishMock().props,
        equals(['id', 'title', true]),
      );
    });

    test('supports value equality', () {
      expect(
        createWishMock(),
        equals(createWishMock()),
      );
    });
  });
}
