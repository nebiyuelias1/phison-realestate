import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/api/property/property_api_client.dart';
import 'package:phison_realestate_mobile/repositories/properties_repository/properties_repository.dart';

import '../../../api/property/models/property.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PropertiesRepository _propertiesRepository;

  HomeBloc(this._propertiesRepository) : super(const HomeState()) {
    on<FeaturedPropertiesQueryRequested>((event, emit) async {
      try {
        emit(state.copyWith(
            featuredPropertiesStatus: FormzStatus.submissionInProgress));

        final result =
            await _propertiesRepository.getProperties(isFeatured: true);
        emit(
          state.copyWith(
            featuredPropertiesStatus: FormzStatus.submissionSuccess,
            featuredProperties: result,
          ),
        );
      } on QueryPropertiesFailure catch (e) {
        emit(state.copyWith(
            featuredPropertiesStatus: FormzStatus.submissionFailure,
            featuredPropertiesError: e.message));
      }
    });
  }
}
