import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/api/property/property_api_client.dart';
import 'package:phison_realestate_mobile/repositories/properties_repository/properties_repository.dart';

import '../../../api/property/models/property.dart';

part 'properties_event.dart';
part 'properties_state.dart';

class PropertiesBloc extends Bloc<PropertiesEvent, PropertiesState> {
  final PropertiesRepository _propertiesRepository;

  PropertiesBloc(this._propertiesRepository) : super(const PropertiesState()) {
    on<FetchNextPageRequested>((event, emit) async {
      try {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));

        final result =
            await _propertiesRepository.getProperties(after: event.nextPage);

        emit(
          state.copyWith(
              status: FormzStatus.submissionSuccess,
              properties: result.items,
              hasNextPage: result.hasNextPage,
              endCursor: result.endCursor),
        );
      } on QueryPropertiesFailure catch (e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, error: e.message));
      }
    });
  }
}
