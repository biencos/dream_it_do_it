import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wishes_repository/wishes_repository.dart';

void main() {
  group('ShowWishesEvent', () {
    final mockWish = Wish(id: 'id_1', title: 'title_1');

    group('WishesSubscriptionRequested', () {
      test('supports value equality', () {
        expect(
          const WishesSubscriptionRequested(),
          equals(const WishesSubscriptionRequested()),
        );
      });

      test('props works correctly', () {
        expect(
          const WishesSubscriptionRequested().props,
          equals(<Object?>[]),
        );
      });
    });

    group('WishCompletionToggled', () {
      test('supports value equality', () {
        expect(
          WishCompletionToggled(
            wish: mockWish,
            isCompleted: true,
          ),
          equals(
            WishCompletionToggled(
              wish: mockWish,
              isCompleted: true,
            ),
          ),
        );
      });

      test('props works correctly', () {
        expect(
          WishCompletionToggled(
            wish: mockWish,
            isCompleted: true,
          ).props,
          equals(<Object?>[
            mockWish,
            true,
          ]),
        );
      });
    });
  });
}
