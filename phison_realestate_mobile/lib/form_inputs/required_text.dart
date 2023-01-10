import 'package:formz/formz.dart';

enum RequiredTextValidationError { invalid }

class RequiredText extends FormzInput<String, RequiredTextValidationError> {
  const RequiredText.pure() : super.pure('');
  const RequiredText.dirty([String value = '']) : super.dirty(value);

  @override
  RequiredTextValidationError? validator(String? value) {
    return value == null || value.isEmpty
        ? RequiredTextValidationError.invalid
        : null;
  }
}
