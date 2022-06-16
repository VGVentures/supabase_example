import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:very_good_supabase/account/account.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: AccountPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(context.read<UserRepository>())
        ..add(const AccountUserInformationFetched()),
      child: const AccountView(),
    );
  }
}
