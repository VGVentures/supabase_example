// ignore_for_file: prefer_const_constructors
import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  const companyNameString = 'company name';
  group('CompanyName', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final companyName = CompanyName.pure();
        expect(companyName.value, '');
        expect(companyName.isPure, true);
      });

      test('dirty creates correct instance', () {
        final companyName = CompanyName.dirty(companyNameString);
        expect(companyName.value, companyNameString);
        expect(companyName.isPure, false);
      });
    });

    group('validator', () {
      test('returns invalid error when company name is empty', () {
        expect(
          CompanyName.dirty().error,
          CompanyNameValidationError.invalid,
        );
      });

      test('is valid when company name is valid', () {
        expect(
          CompanyName.dirty(companyNameString).error,
          isNull,
        );
      });
    });
  });
}
