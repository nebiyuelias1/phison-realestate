part of 'property_detail_bloc.dart';

abstract class PropertyDetailEvent extends Equatable {
  const PropertyDetailEvent();

  @override
  List<Object> get props => [];
}

class GetPropertyDetailRequested extends PropertyDetailEvent {
  final String id;

  const GetPropertyDetailRequested({
    required this.id,
  });

  @override
  List<Object> get props => [props];
}
