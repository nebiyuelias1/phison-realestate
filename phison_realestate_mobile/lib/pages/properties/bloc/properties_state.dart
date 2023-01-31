part of 'properties_bloc.dart';

class PropertiesState extends Equatable {
  const PropertiesState(
      {this.properties = const [],
      this.status = FormzStatus.pure,
      this.error,
      this.hasNextPage = false,
      this.endCursor});
  final List<Property> properties;
  final FormzStatus status;
  final String? error;
  final bool hasNextPage;
  final String? endCursor;

  @override
  List<Object?> get props => [
        properties,
        status,
        error,
        hasNextPage,
        endCursor,
      ];

  PropertiesState copyWith({
    FormzStatus? status,
    List<Property>? properties,
    bool? hasNextPage,
    String? endCursor,
    String? error,
  }) {
    return PropertiesState(
      endCursor: endCursor ?? this.endCursor,
      error: error ?? this.error,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      properties: properties ?? this.properties,
      status: status ?? this.status,
    );
  }
}
