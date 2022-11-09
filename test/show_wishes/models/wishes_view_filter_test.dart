import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wishes_repository/wishes_repository.dart';

void main() {
  group('WishesViewFilter', () {
    final completedWish = Wish(id: 'id_1', title: 'title_1', isCompleted: true);
    final incompletedWish = Wish(id: 'id_2', title: 'title_2');

    group('apply', () {
      test(
        'returns true when filter is .activeOnly and the wish is incomplete',
        () {
          expect(
            WishesViewFilter.activeOnly.apply(completedWish),
            isFalse,
          );
          expect(
            WishesViewFilter.activeOnly.apply(incompletedWish),
            isTrue,
          );
        },
      );

      test(
          'returns true when filter is .completedOnly'
          ' and the wish is completed', () {
        expect(
          WishesViewFilter.completedOnly.apply(incompletedWish),
          isFalse,
        );
        expect(
          WishesViewFilter.completedOnly.apply(completedWish),
          isTrue,
        );
      });
    });

    test(
        'applyAll correctly filters provided iterable based on selected filter',
        () {
      final all = [completedWish, incompletedWish];

      expect(
        WishesViewFilter.activeOnly.applyAll(all),
        equals([incompletedWish]),
      );
      expect(
        WishesViewFilter.completedOnly.applyAll(all),
        equals([completedWish]),
      );
    });
  });
}
