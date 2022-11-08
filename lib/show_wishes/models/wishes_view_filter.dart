import 'package:wishes_repository/wishes_repository.dart';

enum WishesViewFilter { activeOnly, completedOnly }

extension WishesViewFilterX on WishesViewFilter {
  bool apply(Wish wish) {
    switch (this) {
      case WishesViewFilter.activeOnly:
        return !wish.isCompleted;
      case WishesViewFilter.completedOnly:
        return wish.isCompleted;
    }
  }

  Iterable<Wish> applyAll(Iterable<Wish> wishes) {
    return wishes.where(apply);
  }
}
