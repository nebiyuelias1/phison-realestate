part of 'exchange_rate_cubit.dart';

class ExchangeRateState extends Equatable {
  final FormzStatus status;
  final double? usdToEtbRate;

  const ExchangeRateState({
    this.status = FormzStatus.pure,
    this.usdToEtbRate,
  });

  @override
  List<Object?> get props => [
        status,
        usdToEtbRate,
      ];

  ExchangeRateState copyWith({
    FormzStatus? status,
    double? usdToEtbRate,
  }) {
    return ExchangeRateState(
      status: status ?? this.status,
      usdToEtbRate: usdToEtbRate ?? this.usdToEtbRate,
    );
  }
}
