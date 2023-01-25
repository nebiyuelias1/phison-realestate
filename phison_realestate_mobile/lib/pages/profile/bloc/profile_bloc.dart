import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/api/me/me_api_client.dart';
import 'package:phison_realestate_mobile/repositories/me_repository/me_repository.dart';

import '../../../api/me/models/phison_user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final MeRepository _meRepository;

  ProfileBloc(this._meRepository) : super(const ProfileState()) {
    on<GetMeRequested>((event, emit) async {
      try {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));

        final result = await _meRepository.getMe();

        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess,
            user: result,
          ),
        );
      } on GetMeFailure catch (e) {
        emit(
          state.copyWith(
            error: e.message,
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    });
  }
}
