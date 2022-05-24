import 'package:formz/formz.dart';

/// User Name Form Input Validation Error
enum UserNameValidationError {
  /// UserName is invalid (generic validation error)
  invalid
}

/// {@template user_name}
/// Reusable user name form input.
/// {@endtemplate}
class UserName extends FormzInput<String, UserNameValidationError> {
  /// {@macro user_name}
  const UserName.pure() : super.pure('');

  /// {@macro user_name}
  const UserName.dirty([super.value = '']) : super.dirty();

  @override
  UserNameValidationError? validator(String value) {
    return value.isNotEmpty ? null : UserNameValidationError.invalid;
  }
}
