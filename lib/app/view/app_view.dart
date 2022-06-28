import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:very_good_supabase/app/bloc/app_bloc.dart';
import 'package:very_good_supabase/app/routes/routes.dart';
import 'package:very_good_supabase/auth_states_supabase/auth.dart';
import 'package:very_good_supabase/l10n/l10n.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends AuthStateSupabase<AppView> {
  @override
  void initState() {
    super.initState();
    recoverSupabaseSession();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Very Good Supabase',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.teal),
        colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.teal,
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
