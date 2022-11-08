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
