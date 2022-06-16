// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_supabase/login/login.dart';

import '../../helpers/helpers.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late LoginBloc loginBloc;

  setUpAll(() async {
    await initializeSupabase();
  });

  setUp(() async {
    loginBloc = MockLoginBloc();
    when(() => loginBloc.state).thenReturn(LoginState());
  });

  group('LoginPage', () {
    test('has a page', () {
      expect(LoginPage.page(), isA<MaterialPage<void>>());
    });

    testWidgets('renders a LoginView', (tester) async {
      await tester.pumpApp(
        const LoginPage(),
      );
      expect(find.byType(LoginView), findsOneWidget);
    });
  });
}
