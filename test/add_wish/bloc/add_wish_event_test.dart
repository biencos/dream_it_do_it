import 'package:dream_it_do_it/add_wish/add_wish.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddWishEvent', () {
    group('AddWishTitleChanged', () {
      test('supports value equality', () {
        expect(
          const AddWishTitleChanged('title_1'),
          equals(const AddWishTitleChanged('title_1')),
        );
      });

      test('props works correctly', () {
        expect(
          const AddWishTitleChanged('title_1').props,
          equals(<Object?>['title_1']),
        );
      });
    });

    group('AddWishSubmitted', () {
      test('supports value equality', () {
        expect(
          const AddWishSubmitted(),
          equals(const AddWishSubmitted()),
        );
      });

      test('props works correctly', () {
        expect(
          const AddWishSubmitted().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
