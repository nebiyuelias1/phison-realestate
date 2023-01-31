import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

enum NotificationType { paymentDue, paymentCompleted, unknown }

@JsonSerializable(createToJson: false)
class Notification {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isRead;
  @JsonKey(fromJson: _notificationTypeFromJson)
  final NotificationType notificationType;
  @JsonKey(fromJson: _dataFromJson)
  final Map<String, dynamic> data;

  Notification({
    required this.createdAt,
    required this.isRead,
    required this.notificationType,
    required this.data,
    this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  static NotificationType _notificationTypeFromJson(String json) {
    if (json == 'PD') {
      return NotificationType.paymentDue;
    } else if (json == 'PC') {
      return NotificationType.paymentCompleted;
    }

    return NotificationType.unknown;
  }

  static Map<String, dynamic> _dataFromJson(String source) {
    return jsonDecode(jsonDecode(source));
  }
}
