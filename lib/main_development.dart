// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:supabase_database_repository/supabase_database_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:very_good_supabase/app/app.dart';
import 'package:very_good_supabase/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/.env');

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('ANON_KEY'),
  );

  await bootstrap(() {
    final supabaseAuthClient =
        SupabaseAuthClient(auth: Supabase.instance.client.auth);
    final authRepository = AuthRepository(authClient: supabaseAuthClient);

    final supabaseDatabaseClient = SupabaseDatabaseClient(
      supabaseClient: Supabase.instance.client,
    );
    final supabaseDatabaseRepository = SupabaseDatabaseRepository(
      supabaseDatabaseClient: supabaseDatabaseClient,
    );

    return App(
      authRepository: authRepository,
      supabaseDatabaseRepository: supabaseDatabaseRepository,
    );
  });
}
