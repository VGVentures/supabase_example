// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_repository/supabase_auth_repository.dart';
import 'package:very_good_supabase/login/bloc/login_bloc.dart';

class MockSupabaseRepository extends Mock implements SupabaseAuthRepository {}

void main() {
  const invalidEmailString = 'invalid';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  group('LoginBloc', () {
    late SupabaseAuthRepository supabaseAuthRepository;

    setUp(() {
      supabaseAuthRepository = MockSupabaseRepository();
    });

    test('initial state is LoginState', () {
      expect(LoginBloc(supabaseAuthRepository).state, LoginState());
    });

    group('EmailChanged', () {
      blocTest<LoginBloc, LoginState>(
        'emits [invalid] when email is invalid',
        build: () => LoginBloc(supabaseAuthRepository),
        act: (bloc) => bloc.add(LoginEmailChanged(invalidEmailString)),
        expect: () => const <LoginState>[
          LoginState(email: invalidEmail),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [valid] when email is valid',
        build: () => LoginBloc(supabaseAuthRepository),
        act: (bloc) => bloc.add(LoginEmailChanged(validEmailString)),
        expect: () => const <LoginState>[
          LoginState(email: validEmail, valid: true),
        ],
      );
    });

    group('LoginEventSignIn', () {
      blocTest<LoginBloc, LoginState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when sign in succeeds',
        setUp: () {
          when(
            () => supabaseAuthRepository.signIn(
              email: validEmailString,
              isWeb: false,
            ),
          ).thenAnswer((_) async {});
        },
        build: () => LoginBloc(supabaseAuthRepository),
        act: (bloc) => bloc.add(
          LoginEventSignIn(email: validEmailString, isWeb: false),
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
            () => supabaseAuthRepository.signIn(
              email: validEmailString,
              isWeb: false,
            ),
          ).thenThrow(Exception());
        },
        build: () => LoginBloc(supabaseAuthRepository),
        act: (bloc) => bloc.add(
          LoginEventSignIn(email: validEmailString, isWeb: false),
        ),
        expect: () => <LoginState>[
          LoginState(status: FormzSubmissionStatus.inProgress),
          LoginState(status: FormzSubmissionStatus.failure)
        ],
      );
    });

    group('LoginEventSignOut', () {
      blocTest<LoginBloc, LoginState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when sign out succeeds',
        setUp: () {
          when(() => supabaseAuthRepository.signOut()).thenAnswer((_) async {});
        },
        build: () => LoginBloc(supabaseAuthRepository),
        act: (bloc) => bloc.add(
          LoginEventSignOut(),
        ),
        expect: () => <LoginState>[
          LoginState(status: FormzSubmissionStatus.inProgress),
          LoginState(status: FormzSubmissionStatus.success)
        ],
      );
    });

    blocTest<LoginBloc, LoginState>(
      'emits [submissionInProgress, submissionFailure] '
      'when sign out fails',
      setUp: () {
        when(
          () => supabaseAuthRepository.signOut(),
        ).thenThrow(Exception());
      },
      build: () => LoginBloc(supabaseAuthRepository),
      act: (bloc) => bloc.add(
        LoginEventSignOut(),
      ),
      expect: () => <LoginState>[
        LoginState(status: FormzSubmissionStatus.inProgress),
        LoginState(status: FormzSubmissionStatus.failure)
      ],
    );
  });
}
