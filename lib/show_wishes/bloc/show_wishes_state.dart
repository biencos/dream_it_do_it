part of 'show_wishes_bloc.dart';

enum ShowWishesStatus { initial, loading, success, failure }

class ShowWishesState extends Equatable {
  const ShowWishesState({
    this.status = ShowWishesStatus.initial,
    this.wishes = const [],
  });

  final ShowWishesStatus status;
  final List<Wish> wishes;

  ShowWishesState copyWith({
    ShowWishesStatus Function()? status,
    List<Wish> Function()? wishes,
  }) {
    return ShowWishesState(
      status: status != null ? status() : this.status,
      wishes: wishes != null ? wishes() : this.wishes,
    );
  }

  @override
  List<Object?> get props => [
        status,
        wishes,
      ];
}
