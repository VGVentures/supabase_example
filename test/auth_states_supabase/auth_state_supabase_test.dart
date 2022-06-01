// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:very_good_supabase/app/app.dart';
import 'package:very_good_supabase/auth_states_supabase/auth.dart';

import '../helpers/helpers.dart';

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

class FakeSession extends Fake implements Session {}

void main() {
  late AppBloc appBloc;

  setUpAll(() async {
    await initializeSupabase();
  });

  setUp(() {
    appBloc = MockAppBloc();
    when(() => appBloc.state).thenReturn(AppState());
  });

  group('AuthStateSupabase', () {
    testWidgets('onUnauthenticated adds AppLogoutRequested', (tester) async {
      await tester.pumpApp(
        AuthStateWidget(),
        appBloc: appBloc,
      );
      tester
          .state<_AuthStateWidgetState>(find.byType(AuthStateWidget))
          .onUnauthenticated();
      await tester.pumpAndSettle();
      verify(() => appBloc.add(AppUnauthenticated())).called(1);
    });

    testWidgets('onAuthenticated adds AppAuthenticated', (tester) async {
      await tester.pumpApp(
        AuthStateWidget(),
        appBloc: appBloc,
      );
      tester
          .state<_AuthStateWidgetState>(find.byType(AuthStateWidget))
          .onAuthenticated(FakeSession());
      await tester.pumpAndSettle();
      verify(() => appBloc.add(AppAuthenticated())).called(1);
    });
  });
}

class AuthStateWidget extends StatefulWidget {
  const AuthStateWidget({super.key});

  @override
  State<AuthStateWidget> createState() => _AuthStateWidgetState();
}

class _AuthStateWidgetState extends AuthStateSupabase<AuthStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
