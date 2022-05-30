// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_auth_repository/supabase_auth_repository.dart';
import 'package:supabase_database_repository/supabase_database_repository.dart';
import 'package:very_good_supabase/app/app.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.supabaseAuthRepository,
    required this.supabaseDatabaseRepository,
  }) : super(key: key);

  final SupabaseAuthRepository supabaseAuthRepository;
  final SupabaseDatabaseRepository supabaseDatabaseRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: supabaseAuthRepository),
        RepositoryProvider.value(value: supabaseDatabaseRepository),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(),
        child: const AppView(),
      ),
    );
  }
}
