import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:very_good_supabase/app/app.dart';

class AuthRequiredState<T extends StatefulWidget>
    extends SupabaseAuthRequiredState<T> {
  @override
  void onUnauthenticated() {
    if (mounted) {
      context.read<AppBloc>().add(AppUnauthenticated());
    }
  }
}
