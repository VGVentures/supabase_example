// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_supabase/account/account.dart';
import 'package:very_good_supabase/app/app.dart';
import 'package:very_good_supabase/login/login.dart';

import '../../helpers/helpers.dart';

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

void main() {
  late AppBloc appBloc;

  setUpAll(() async {
    await initializeSupabase();
  });

  setUp(() {
    appBloc = MockAppBloc();

    when(() => appBloc.state).thenReturn(AppState());
  });

  group('AppView', () {
    testWidgets('navigates to LoginPage when unauthenticated', (tester) async {
      when(() => appBloc.state).thenReturn(AppState());

      await tester.pumpApp(
        AppView(),
        appBloc: appBloc,
      );
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('navigates to AccountPage when authenticated', (tester) async {
      when(() => appBloc.state).thenReturn(
        AppState(status: AppStatus.authenticated),
      );

      await tester.pumpApp(
        const AppView(),
        appBloc: appBloc,
      );
      expect(find.byType(AccountPage), findsOneWidget);
    });
  });
}
