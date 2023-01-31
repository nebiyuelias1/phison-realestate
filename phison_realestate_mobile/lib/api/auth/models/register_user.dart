import 'package:json_annotation/json_annotation.dart';

part 'register_user.g.dart';

@JsonSerializable(createFactory: false, createToJson: true)
class RegisterUser {
  final String name;
  final String email;
  final String phoneNumber;
  final String token;

  RegisterUser({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.token,
  });

  Map<String, dynamic> toJson() => _$RegisterUserToJson(this);
}
