import 'package:json_annotation/json_annotation.dart';

part 'phison_user.g.dart';

@JsonSerializable(createToJson: false)
class PhisonUser {
  final String email;
  final String name;
  final String phoneNumber;

  PhisonUser({
    required this.email,
    required this.name,
    required this.phoneNumber,
  });

  factory PhisonUser.fromJson(Map<String, dynamic> json) =>
      _$PhisonUserFromJson(json);
}
