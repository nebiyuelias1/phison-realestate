import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/api/payment_schedule/payment_schedule_api_client.dart';
import 'package:phison_realestate_mobile/repositories/payment_schedule_repository/payment_schedule_repository.dart';

part 'exchange_rate_state.dart';

class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  final PaymentScheduleRepository _paymentScheduleRepository;

  ExchangeRateCubit(this._paymentScheduleRepository)
      : super(const ExchangeRateState());

  getExchangeRate() async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final rate = await _paymentScheduleRepository.getUsdToEtbExchangeRate();

      emit(
        state.copyWith(
            status: FormzStatus.submissionSuccess, usdToEtbRate: rate),
      );
    } on GetExchangeRateFailure {
      emit(
        state.copyWith(status: FormzStatus.submissionFailure),
      );
    }
  }
}
