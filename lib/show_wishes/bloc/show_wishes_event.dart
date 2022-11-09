part of 'show_wishes_bloc.dart';

abstract class ShowWishesEvent extends Equatable {
  const ShowWishesEvent();

  @override
  List<Object> get props => [];
}

class WishesSubscriptionRequested extends ShowWishesEvent {
  const WishesSubscriptionRequested();
}

class WishCompletionToggled extends ShowWishesEvent {
  const WishCompletionToggled({
    required this.wish,
    required this.isCompleted,
  });

  final Wish wish;
  final bool isCompleted;

  @override
  List<Object> get props => [wish, isCompleted];
}

class WishesFilterChanged extends ShowWishesEvent {
  const WishesFilterChanged(this.filter);

  final WishesViewFilter filter;

  @override
  List<Object> get props => [filter];
}

class WishDeleted extends ShowWishesEvent {
  const WishDeleted(this.wish);

  final Wish wish;

  @override
  List<Object> get props => [wish];
}
