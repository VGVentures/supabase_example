import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:very_good_supabase/app/app.dart';

class AuthStateSupabase<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    context.read<AppBloc>().add(AppUnauthenticated());
  }

  @override
  void onAuthenticated(Session session) {
    context.read<AppBloc>().add(const AppAuthenticated());
  }

// coverage:ignore-start
  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {}
// coverage:ignore-end
}
