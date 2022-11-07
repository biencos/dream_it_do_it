part of 'add_wish_bloc.dart';

enum AddWishStatus { initial, loading, success, failure }

class AddWishState extends Equatable {
  const AddWishState({
    this.status = AddWishStatus.initial,
    this.title = '',
  });

  final AddWishStatus status;
  final String title;

  AddWishState copyWith({
    AddWishStatus? status,
    String? title,
  }) {
    return AddWishState(
      status: status ?? this.status,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [
        status,
        title,
      ];
}
