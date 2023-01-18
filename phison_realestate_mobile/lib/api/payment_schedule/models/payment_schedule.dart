import 'package:json_annotation/json_annotation.dart';

part 'payment_schedule.g.dart';

enum PaymentScheduleStatus {
  pending,
  completed,
}

@JsonSerializable(createToJson: false)
class PaymentSchedule {
  final String title;
  final String description;
  final DateTime deadline;
  final double amount;
  @JsonKey(fromJson: _paymentScheduleStatusFromJson)
  final PaymentScheduleStatus status;

  PaymentSchedule({
    required this.title,
    required this.description,
    required this.deadline,
    required this.amount,
    required this.status,
  });

  factory PaymentSchedule.fromJson(Map<String, dynamic> json) =>
      _$PaymentScheduleFromJson(json);

  static PaymentScheduleStatus _paymentScheduleStatusFromJson(String json) {
    if (json == 'CP') {
      return PaymentScheduleStatus.completed;
    }

    return PaymentScheduleStatus.pending;
  }
}
