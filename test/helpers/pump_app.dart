// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:supabase_auth_repository/supabase_auth_repository.dart';
import 'package:supabase_database_repository/supabase_database_repository.dart';
import 'package:very_good_supabase/app/app.dart';
import 'package:very_good_supabase/l10n/l10n.dart';
import 'package:very_good_supabase/login/login.dart';

class MockSupabaseAuthRepository extends Mock
    implements SupabaseAuthRepository {}

class MockSupabaseDatabaseRepository extends Mock
    implements SupabaseDatabaseRepository {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {
  @override
  AppState get state => const AppState();
}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    SupabaseAuthRepository? supabaseAuthRepository,
    SupabaseDatabaseRepository? supabaseDatabaseRepository,
    AppBloc? appBloc,
    LoginBloc? loginBloc,
    TargetPlatform? platform,
    MockNavigator? navigator,
    NavigatorObserver? navigatorObserver,
  }) async {
    await mockNetworkImages(
      () async => pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(
              value: supabaseAuthRepository ?? MockSupabaseAuthRepository(),
            ),
            RepositoryProvider.value(
              value: supabaseDatabaseRepository ??
                  MockSupabaseDatabaseRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: appBloc ?? MockAppBloc()),
              BlocProvider.value(value: loginBloc ?? MockLoginBloc()),
            ],
            child: MaterialApp(
              title: 'Very Good Supabase',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: Theme(
                data: ThemeData(platform: platform),
                child: navigator == null
                    ? Scaffold(body: widgetUnderTest)
                    : MockNavigatorProvider(
                        navigator: navigator,
                        child: Scaffold(body: widgetUnderTest),
                      ),
              ),
              navigatorObservers: [
                if (navigatorObserver != null) navigatorObserver
              ],
            ),
          ),
        ),
      ),
    );
    await pump();
  }
}
