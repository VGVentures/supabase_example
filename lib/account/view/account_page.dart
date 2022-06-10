import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_database_repository/supabase_database_repository.dart';
import 'package:very_good_supabase/account/account.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static Page page() => const MaterialPage<void>(child: AccountPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(
        context.read<SupabaseDatabaseRepository>(),
        context.read<AuthRepository>(),
      )..add(const AccountUserInformationFetched()),
      child: const AccountView(),
    );
  }
}
