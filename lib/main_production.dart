// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_repository/user_repository.dart';
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
    final authClient = SupabaseAuthClient(
      auth: Supabase.instance.client.auth,
    );
    final databaseClient = SupabaseDatabaseClient(
      supabaseClient: Supabase.instance.client,
    );
    final userRepository = UserRepository(
      authClient: authClient,
      databaseClient: databaseClient,
    );

    return App(userRepository: userRepository);
  });
}
