import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wishes_repository/wishes_repository.dart';

part 'add_wish_event.dart';
part 'add_wish_state.dart';

class AddWishBloc extends Bloc<AddWishEvent, AddWishState> {
  AddWishBloc({
    required WishesRepository wishesRepository,
  })  : _wishesRepository = wishesRepository,
        super(const AddWishState()) {
    on<AddWishTitleChanged>(_onAddWishTitleChanged);
    on<AddWishSubmitted>(_onAddWishSubmitted);
  }

  final WishesRepository _wishesRepository;

  Future<void> _onAddWishTitleChanged(
    AddWishTitleChanged event,
    Emitter<AddWishState> emit,
  ) async {
    emit(state.copyWith(title: event.title));
  }

  Future<void> _onAddWishSubmitted(
    AddWishSubmitted event,
    Emitter<AddWishState> emit,
  ) async {
    emit(state.copyWith(status: AddWishStatus.loading));
    final wish = Wish(title: state.title);
    try {
      await _wishesRepository.saveWish(wish);
      emit(state.copyWith(status: AddWishStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddWishStatus.failure));
    }
  }
}
