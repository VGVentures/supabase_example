// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_database_repository/supabase_database_repository.dart';
import 'package:very_good_supabase/app/app.dart';

class App extends StatelessWidget {
  const App({
    required this.authRepository,
    required this.supabaseDatabaseRepository,
    super.key,
  });

  final AuthRepository authRepository;
  final SupabaseDatabaseRepository supabaseDatabaseRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: supabaseDatabaseRepository),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(),
        child: const AppView(),
      ),
    );
  }
}
