import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/api/property/property_api_client.dart';
import 'package:phison_realestate_mobile/repositories/properties_repository/properties_repository.dart';

import '../../../api/property/models/property.dart';

part 'property_detail_event.dart';
part 'property_detail_state.dart';

class PropertyDetailBloc
    extends Bloc<PropertyDetailEvent, PropertyDetailState> {
  final PropertiesRepository _propertiesRepository;

  PropertyDetailBloc({
    required Property property,
    required PropertiesRepository propertiesRepository,
  })  : _propertiesRepository = propertiesRepository,
        super(PropertyDetailState(
          property: property,
        )) {
    on<GetPropertyDetailRequested>((event, emit) async {
      try {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));

        final result = await _propertiesRepository.getPropertyDetail(event.id);

        emit(state.copyWith(
            status: FormzStatus.submissionSuccess, property: result));
      } on PropertyDetailQueryFailure catch (e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, error: e.message));
      }
    });
  }
}
