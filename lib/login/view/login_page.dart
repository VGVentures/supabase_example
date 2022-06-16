import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:very_good_supabase/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(context.read<UserRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: const LoginView(),
      ),
    );
  }
}
