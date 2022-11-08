import 'package:bloc/bloc.dart';
import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:equatable/equatable.dart';
import 'package:wishes_repository/wishes_repository.dart';

part 'show_wishes_event.dart';
part 'show_wishes_state.dart';

class ShowWishesBloc extends Bloc<ShowWishesEvent, ShowWishesState> {
  ShowWishesBloc({
    required WishesRepository wishesRepository,
  })  : _wishesRepository = wishesRepository,
        super(const ShowWishesState()) {
    on<WishesSubscriptionRequested>(_onSubscriptionRequested);
    on<WishCompletionToggled>(_onWishCompletionToggled);
    on<WishesFilterChanged>(_onFilterChanged);
  }

  final WishesRepository _wishesRepository;

  Future<void> _onSubscriptionRequested(
    WishesSubscriptionRequested event,
    Emitter<ShowWishesState> emit,
  ) async {
    emit(state.copyWith(status: () => ShowWishesStatus.loading));

    await emit.forEach<List<Wish>>(
      _wishesRepository.getWishes(),
      onData: (wishes) => state.copyWith(
        status: () => ShowWishesStatus.success,
        wishes: () => wishes,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ShowWishesStatus.failure,
      ),
    );
  }

  Future<void> _onWishCompletionToggled(
    WishCompletionToggled event,
    Emitter<ShowWishesState> emit,
  ) async {
    final newWish = event.wish.copyWith(isCompleted: event.isCompleted);
    await _wishesRepository.saveWish(newWish);
  }

  void _onFilterChanged(
    WishesFilterChanged event,
    Emitter<ShowWishesState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
