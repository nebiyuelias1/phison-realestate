part of 'property_detail_bloc.dart';

class PropertyDetailState extends Equatable {
  final Property property;
  final FormzStatus status;
  final String? error;

  const PropertyDetailState({
    required this.property,
    this.status = FormzStatus.pure,
    this.error,
  });

  @override
  List<Object> get props => [
        property,
        status,
      ];

  PropertyDetailState copyWith(
      {FormzStatus? status, Property? property, String? error}) {
    return PropertyDetailState(
      status: status ?? this.status,
      property: property ?? this.property,
      error: error ?? this.error,
    );
  }
}
