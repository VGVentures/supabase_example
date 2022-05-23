// ignore_for_file: prefer_const_constructors
import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  const userNameString = 'user name';
  group('UserName', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final userName = UserName.pure();
        expect(userName.value, '');
        expect(userName.isPure, true);
      });

      test('dirty creates correct instance', () {
        final userName = UserName.dirty(userNameString);
        expect(userName.value, userNameString);
        expect(userName.isPure, false);
      });
    });

    group('validator', () {
      test('returns invalid error when user name is empty', () {
        expect(
          UserName.dirty().error,
          UserNameValidationError.invalid,
        );
      });

      test('is valid when user name is valid', () {
        expect(
          UserName.dirty(userNameString).error,
          isNull,
        );
      });
    });
  });
}
