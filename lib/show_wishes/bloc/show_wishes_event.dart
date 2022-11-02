part of 'show_wishes_bloc.dart';

abstract class ShowWishesEvent extends Equatable {
  const ShowWishesEvent();

  @override
  List<Object> get props => [];
}

class WishesSubscriptionRequested extends ShowWishesEvent {
  const WishesSubscriptionRequested();
}
