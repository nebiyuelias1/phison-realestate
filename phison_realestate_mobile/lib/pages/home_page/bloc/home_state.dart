part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.featuredProperties = const [],
    this.featuredPropertiesStatus = FormzStatus.pure,
    this.featuredPropertiesError,
    this.properties = const [],
    this.status = FormzStatus.pure,
    this.error,
    this.hasUnreadNotifications = false,
  });
  final List<Property> featuredProperties;
  final FormzStatus featuredPropertiesStatus;
  final String? featuredPropertiesError;

  final List<Property> properties;
  final FormzStatus status;
  final String? error;

  final bool hasUnreadNotifications;

  @override
  List<Object?> get props => [
        featuredProperties,
        featuredPropertiesStatus,
        featuredPropertiesError,
        properties,
        status,
        error,
        hasUnreadNotifications,
      ];

  HomeState copyWith(
      {FormzStatus? featuredPropertiesStatus,
      List<Property>? featuredProperties,
      String? featuredPropertiesError,
      FormzStatus? status,
      List<Property>? properties,
      String? error,
      bool? hasUnreadNotifications}) {
    return HomeState(
      error: error ?? this.error,
      featuredProperties: featuredProperties ?? this.featuredProperties,
      featuredPropertiesError:
          featuredPropertiesError ?? this.featuredPropertiesError,
      featuredPropertiesStatus:
          featuredPropertiesStatus ?? this.featuredPropertiesStatus,
      properties: properties ?? this.properties,
      status: status ?? this.status,
      hasUnreadNotifications:
          hasUnreadNotifications ?? this.hasUnreadNotifications,
    );
  }
}
