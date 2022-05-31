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

  group('AuthRequiredState', () {
    testWidgets('onUnauthenticated adds AppLogoutRequested', (tester) async {
      await tester.pumpApp(
        AuthRequiredStateWidget(),
        appBloc: appBloc,
      );
      tester
          .state<_AuthRequiredStateWidgetState>(
            find.byType(AuthRequiredStateWidget),
          )
          .onUnauthenticated();
      await tester.pumpAndSettle();
      verify(() => appBloc.add(AppUnauthenticated())).called(1);
    });
  });
}

class AuthRequiredStateWidget extends StatefulWidget {
  const AuthRequiredStateWidget({super.key});

  @override
  State<AuthRequiredStateWidget> createState() =>
      _AuthRequiredStateWidgetState();
}

class _AuthRequiredStateWidgetState
    extends AuthRequiredState<AuthRequiredStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
