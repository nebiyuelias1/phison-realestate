import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/repositories/core/item_repository.dart';
import 'package:phison_realestate_mobile/repositories/core/query_items_failure.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc<T, R> extends Bloc<ItemsEvent<R>, ItemsState<T>> {
  final ItemRepository<R> _itemsRepository;

  ItemsBloc(this._itemsRepository) : super(ItemsState<T>()) {
    on<FetchNextPageRequested<R>>((event, emit) async {
      try {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));

        final result = await _itemsRepository.getItems(event.param);

        emit(
          state.copyWith(
              status: FormzStatus.submissionSuccess,
              properties: result.items.cast<T>(),
              hasNextPage: result.hasNextPage,
              endCursor: result.endCursor),
        );
      } on QueryItemsFailure catch (e) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            error: e.message,
          ),
        );
      }
    });
  }
}
