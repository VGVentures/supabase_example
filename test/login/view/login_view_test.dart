// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_supabase/login/login.dart';

import '../../helpers/helpers.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockEmailLauncher extends Mock implements EmailLauncher {}

void main() {
  late EmailLauncher emailLauncher;

  const sendEmailButtonKey = Key('loginView_sendEmail_button');

  const emailInputKey = Key('loginView_emailInput_textField');
  const testEmail = 'test@gmail.com';

  late LoginBloc loginBloc;

  setUpAll(() async {
    await initializeSupabase();
  });

  setUp(() async {
    emailLauncher = MockEmailLauncher();

    loginBloc = MockLoginBloc();
    when(() => loginBloc.state).thenReturn(LoginState());
  });

  group('adds', () {
    testWidgets('LoginEmailChanged when email changes', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: loginBloc,
          child: LoginView(),
        ),
      );
      await tester.enterText(find.byKey(emailInputKey), testEmail);
      await tester.pumpAndSettle();

      verify(() => loginBloc.add(LoginEmailChanged(testEmail))).called(1);
    });

    testWidgets('LoginSubmitted when SendEmailButton is pressed',
        (tester) async {
      when(() => loginBloc.state).thenReturn(
        const LoginState(email: Email.dirty(testEmail), valid: true),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: loginBloc,
          child: LoginView(),
        ),
      );
      await tester.tap(find.byKey(sendEmailButtonKey));
      await tester.pumpAndSettle();

      verify(
        () => loginBloc.add(LoginSubmitted(email: testEmail, isWeb: false)),
      ).called(1);
    });
  });
  group('opens default email app', () {
    testWidgets(
      'when OpenEmailButton is pressed',
      (tester) async {
        when(() => loginBloc.state).thenReturn(
          LoginState(
            status: FormzSubmissionStatus.success,
            valid: true,
          ),
        );
        when(emailLauncher.launchEmailApp).thenAnswer((_) async {});
        await tester.pumpApp(
          BlocProvider.value(
            value: loginBloc,
            child: OpenEmailButton(
              emailLauncher: emailLauncher,
            ),
          ),
        );
        await tester.tap(find.byType(OpenEmailButton));
        await tester.pumpAndSettle();
        verify(emailLauncher.launchEmailApp).called(1);
      },
    );
  });
}
