part of 'add_wish_bloc.dart';

abstract class AddWishEvent extends Equatable {
  const AddWishEvent();

  @override
  List<Object> get props => [];
}

class AddWishTitleChanged extends AddWishEvent {
  const AddWishTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class AddWishSubmitted extends AddWishEvent {
  const AddWishSubmitted();
}
