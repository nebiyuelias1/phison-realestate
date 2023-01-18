// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentSchedule _$PaymentScheduleFromJson(Map<String, dynamic> json) =>
    PaymentSchedule(
      title: json['title'] as String,
      description: json['description'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      amount: (json['amount'] as num).toDouble(),
      status: PaymentSchedule._paymentScheduleStatusFromJson(
          json['status'] as String),
    );
