import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShowWishesEvent', () {
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
  });
}
