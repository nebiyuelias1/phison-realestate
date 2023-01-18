part of 'items_bloc.dart';

class ItemsState<T> extends Equatable {
  const ItemsState(
      {this.items = const [],
      this.status = FormzStatus.pure,
      this.error,
      this.hasNextPage = false,
      this.endCursor});
  final List<T> items;
  final FormzStatus status;
  final String? error;
  final bool hasNextPage;
  final String? endCursor;

  @override
  List<Object?> get props => [
        items,
        status,
        error,
        hasNextPage,
        endCursor,
      ];

  ItemsState<T> copyWith({
    FormzStatus? status,
    List<T>? properties,
    bool? hasNextPage,
    String? endCursor,
    String? error,
  }) {
    return ItemsState(
      endCursor: endCursor ?? this.endCursor,
      error: error ?? this.error,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      items: properties ?? this.items,
      status: status ?? this.status,
    );
  }
}
