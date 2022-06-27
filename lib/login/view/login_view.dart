import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:very_good_supabase/auth_states_supabase/auth.dart';
import 'package:very_good_supabase/gen/assets.gen.dart';
import 'package:very_good_supabase/login/login.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends AuthStateSupabase<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 32,
      ),
      children: [
        const _Header(),
        const SizedBox(height: 18),
        const _EmailInput(),
        const SizedBox(height: 28),
        const _SendEmailButton(),
        const SizedBox(height: 28),
        if (!kIsWeb) OpenEmailButton()
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('loginView_header'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox.square(
              dimension: 100,
              child: Assets.images.supabase.image(),
            ),
            SizedBox(
              width: 200,
              height: 100,
              child: Assets.images.vgv.image(),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Text(
            'Sign in via the magic link',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (LoginBloc bloc) => bloc.state.status == FormzSubmissionStatus.inProgress,
    );
    return TextFormField(
      key: const Key('loginView_emailInput_textField'),
      readOnly: isInProgress,
      onChanged: (email) {
        context.read<LoginBloc>().add(LoginEmailChanged(email));
      },
      decoration: const InputDecoration(labelText: 'Email'),
    );
  }
}

class _SendEmailButton extends StatelessWidget {
  const _SendEmailButton();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;

    return ElevatedButton(
      key: const Key('loginView_sendEmail_button'),
      onPressed: state.status.isInProgress || !state.valid
          ? null
          : () => context.read<LoginBloc>().add(
                LoginSubmitted(
                  email: state.email.value,
                  isWeb: kIsWeb,
                ),
              ),
      child: Text(
        state.status.isInProgress ? 'Loading' : 'Send Magic Link',
      ),
    );
  }
}

@visibleForTesting
class OpenEmailButton extends StatelessWidget {
  OpenEmailButton({
    EmailLauncher? emailLauncher,
    super.key,
  }) : _emailLauncher = emailLauncher ?? EmailLauncher();

  final EmailLauncher _emailLauncher;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;

    return OutlinedButton(
      key: const Key('loginView_openEmail_button'),
      onPressed: state.status.isInProgress || !state.valid
          ? null
          : _emailLauncher.launchEmailApp,
      child: const Text('Open Email App'),
    );
  }
}
