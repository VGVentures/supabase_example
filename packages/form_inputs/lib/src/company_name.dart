import 'package:formz/formz.dart';

/// Company Name Form Input Validation Error.
enum CompanyNameValidationError {
  /// Company Name is invalid (generic validation error).
  invalid
}

/// {@template company_name}
/// Reusable company name form input.
/// {@endtemplate}
class CompanyName extends FormzInput<String, CompanyNameValidationError> {
  /// {@macro company_name}
  const CompanyName.pure() : super.pure('');

  /// {@macro company_name}
  const CompanyName.dirty([super.value = '']) : super.dirty();

  @override
  CompanyNameValidationError? validator(String value) {
    return value.isNotEmpty ? null : CompanyNameValidationError.invalid;
  }
}
