// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_supabase/app/app.dart';

void main() {
  group('AppBloc', () {
    test('initial state is unauthenticated', () {
      expect(
        AppBloc().state,
        AppState(),
      );
    });

    group('AppLogoutRequested', () {
      blocTest<AppBloc, AppState>(
        'emits [AppStatus.unauthenticated] when '
        'state is unauthenticated',
        build: AppBloc.new,
        act: (bloc) => bloc.add(AppLogoutRequested()),
        expect: () => <AppState>[AppState()],
      );
    });

    group('AppAuthenticated', () {
      blocTest<AppBloc, AppState>(
        'emits [AppStatus.authenticated] when '
        'state is authenticated',
        build: AppBloc.new,
        act: (bloc) => bloc.add(AppAuthenticated()),
        expect: () => <AppState>[
          AppState(
            status: AppStatus.authenticated,
          )
        ],
      );
    });
  });
}
