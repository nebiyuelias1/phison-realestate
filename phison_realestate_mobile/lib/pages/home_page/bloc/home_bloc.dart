import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/api/property/property_api_client.dart';
import 'package:phison_realestate_mobile/repositories/notification_repository/notification_repository.dart';
import 'package:phison_realestate_mobile/repositories/properties_repository/properties_repository.dart';

import '../../../api/property/models/property.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PropertiesRepository _propertiesRepository;
  final NotificationRepository _notificationRepository;

  HomeBloc(
      {required PropertiesRepository propertiesRepository,
      required NotificationRepository notificationRepository})
      : _propertiesRepository = propertiesRepository,
        _notificationRepository = notificationRepository,
        super(const HomeState()) {
    on<FeaturedPropertiesQueryRequested>((event, emit) async {
      try {
        emit(state.copyWith(
            featuredPropertiesStatus: FormzStatus.submissionInProgress));

        final result =
            await _propertiesRepository.getProperties(isFeatured: true);
        emit(
          state.copyWith(
            featuredPropertiesStatus: FormzStatus.submissionSuccess,
            featuredProperties: result.items,
          ),
        );
      } on QueryPropertiesFailure catch (e) {
        emit(state.copyWith(
            featuredPropertiesStatus: FormzStatus.submissionFailure,
            featuredPropertiesError: e.message));
      }
    });
    on<PropertiesQueryRequested>((event, emit) async {
      try {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));

        final result =
            await _propertiesRepository.getProperties(isFeatured: false);

        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess,
            properties: result.items,
          ),
        );
      } on QueryPropertiesFailure catch (e) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            error: e.message,
          ),
        );
      }
    });
    on<UnreadNotificationsCountRequested>((event, emit) async {
      try {
        final result = await _notificationRepository.hasUnreadNotifications();
        emit(state.copyWith(hasUnreadNotifications: result));
      } catch (_) {}
    });
  }
}
