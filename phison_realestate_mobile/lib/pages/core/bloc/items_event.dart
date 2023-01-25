part of 'items_bloc.dart';

abstract class ItemsEvent<T> extends Equatable {
  const ItemsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNextPageRequested <T>extends ItemsEvent<T> {
  final T param;

  const FetchNextPageRequested({required this.param});

  @override
  List<Object?> get props => [param];
}
