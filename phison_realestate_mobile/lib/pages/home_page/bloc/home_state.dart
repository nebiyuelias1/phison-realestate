part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.featuredProperties = const [],
    this.featuredPropertiesStatus = FormzStatus.pure,
    this.featuredPropertiesError,
    this.properties = const [],
    this.status = FormzStatus.pure,
    this.error,
  });
  final List<Property> featuredProperties;
  final FormzStatus featuredPropertiesStatus;
  final String? featuredPropertiesError;

  final List<Property> properties;
  final FormzStatus status;
  final String? error;

  @override
  List<Object?> get props => [
        featuredProperties,
        featuredPropertiesStatus,
        featuredPropertiesError,
        properties,
        status,
        error,
      ];

  HomeState copyWith({
    FormzStatus? featuredPropertiesStatus,
    List<Property>? featuredProperties,
    String? featuredPropertiesError,
  }) {
    return HomeState(
      error: error,
      featuredProperties: featuredProperties ?? this.featuredProperties,
      featuredPropertiesError:
          featuredPropertiesError ?? this.featuredPropertiesError,
      featuredPropertiesStatus:
          featuredPropertiesStatus ?? this.featuredPropertiesStatus,
      properties: properties,
      status: status,
    );
  }
}
