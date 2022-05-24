// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_supabase/login/bloc/login_bloc.dart';

void main() {
  const email = 'test@gmail.com';

  group('LoginEvent', () {
    group('LoginEmailChanged', () {
      test('supports value comparisons', () {
        expect(
          LoginEmailChanged('test@gmail.com'),
          LoginEmailChanged('test@gmail.com'),
        );
        expect(
          LoginEmailChanged(''),
          isNot(LoginEmailChanged('test@gmail.com')),
        );
      });
    });

    group('LoginEventSignIn', () {
      test('supports value comparisons', () {
        expect(
          LoginEventSignIn(email: email, isWeb: false),
          LoginEventSignIn(email: email, isWeb: false),
        );
      });
    });

    group('LoginEventSignOut', () {
      test('supports value comparisons', () {
        expect(
          LoginEventSignOut(),
          LoginEventSignOut(),
        );
      });
    });
  });
}
