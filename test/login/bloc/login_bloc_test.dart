// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';
import 'package:very_good_supabase/login/bloc/login_bloc.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  const invalidEmailString = 'invalid';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  group('LoginBloc', () {
    late UserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
    });

    test('initial state is LoginState', () {
      expect(LoginBloc(userRepository).state, LoginState());
    });

    group('EmailChanged', () {
      blocTest<LoginBloc, LoginState>(
        'emits [invalid] when email is invalid',
        build: () => LoginBloc(userRepository),
        act: (bloc) => bloc.add(LoginEmailChanged(invalidEmailString)),
        expect: () => const <LoginState>[
          LoginState(email: invalidEmail),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [valid] when email is valid',
        build: () => LoginBloc(userRepository),
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
            () => userRepository.signIn(email: validEmailString, isWeb: false),
          ).thenAnswer((_) async {});
        },
        build: () => LoginBloc(userRepository),
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
            () => userRepository.signIn(email: validEmailString, isWeb: false),
          ).thenThrow(Exception());
        },
        build: () => LoginBloc(userRepository),
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
