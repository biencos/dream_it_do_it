part of 'show_wishes_bloc.dart';

enum ShowWishesStatus { initial, loading, success, failure }

class ShowWishesState extends Equatable {
  const ShowWishesState({
    this.status = ShowWishesStatus.initial,
    this.wishes = const [],
    this.filter = WishesViewFilter.activeOnly,
  });

  final ShowWishesStatus status;
  final List<Wish> wishes;
  final WishesViewFilter filter;

  Iterable<Wish> get filteredWishes => filter.applyAll(wishes);

  ShowWishesState copyWith({
    ShowWishesStatus Function()? status,
    List<Wish> Function()? wishes,
    WishesViewFilter Function()? filter,
  }) {
    return ShowWishesState(
      status: status != null ? status() : this.status,
      wishes: wishes != null ? wishes() : this.wishes,
      filter: filter != null ? filter() : this.filter,
    );
  }

  @override
  List<Object?> get props => [
        status,
        wishes,
        filter,
      ];
}
