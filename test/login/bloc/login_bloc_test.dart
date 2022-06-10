// ignore_for_file: prefer_const_constructors

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_supabase/login/bloc/login_bloc.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  const invalidEmailString = 'invalid';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  group('LoginBloc', () {
    late AuthRepository authRepository;

    setUp(() {
      authRepository = MockAuthRepository();
    });

    test('initial state is LoginState', () {
      expect(LoginBloc(authRepository).state, LoginState());
    });

    group('EmailChanged', () {
      blocTest<LoginBloc, LoginState>(
        'emits [invalid] when email is invalid',
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginEmailChanged(invalidEmailString)),
        expect: () => const <LoginState>[
          LoginState(email: invalidEmail),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [valid] when email is valid',
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginEmailChanged(validEmailString)),
        expect: () => const <LoginState>[
          LoginState(email: validEmail, valid: true),
        ],
      );
    });

    group('LoginSubmitted', () {
      blocTest<LoginBloc, LoginState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when sign in succeeds',
        setUp: () {
          when(
            () => authRepository.signIn(
              email: validEmailString,
              isWeb: false,
            ),
          ).thenAnswer((_) async {});
        },
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(
          LoginSubmitted(email: validEmailString, isWeb: false),
        ),
        expect: () => <LoginState>[
          LoginState(status: FormzSubmissionStatus.inProgress),
          LoginState(status: FormzSubmissionStatus.success)
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [submissionInProgress, submissionFailure] '
        'when sign in fails',
        setUp: () {
          when(
            () => authRepository.signIn(
              email: validEmailString,
              isWeb: false,
            ),
          ).thenThrow(Exception());
        },
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(
          LoginSubmitted(email: validEmailString, isWeb: false),
        ),
        expect: () => <LoginState>[
          LoginState(status: FormzSubmissionStatus.inProgress),
          LoginState(status: FormzSubmissionStatus.failure)
        ],
      );
    });
  });
}
