import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:very_good_supabase/account/account.dart';
import 'package:very_good_supabase/auth_states_supabase/auth.dart';
import 'package:very_good_supabase/gen/gen.dart';
import 'package:very_good_supabase/utils/utils.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  AccountViewState createState() => AccountViewState();
}

class AccountViewState extends AuthRequiredState<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state.status.isUpdate) {
            context.showSnackBar(message: 'Updated!');
          }
        },
        buildWhen: (previous, current) =>
            current.status.isSuccess ||
            current.status.isUpdate ||
            current.status.isEditing,
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(28),
            children: const [
              _Header(),
              _UserNameTextField(),
              _UserCompanyNameTextField(),
              SizedBox(height: 50),
              _UpdateUserButton(),
              SizedBox(height: 18),
              _SignOutButton(),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('account_header'),
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
            'Update your information 🦄',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}

class _UserNameTextField extends StatefulWidget {
  const _UserNameTextField();

  @override
  State<_UserNameTextField> createState() => _UserNameTextFieldState();
}

class _UserNameTextFieldState extends State<_UserNameTextField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          _controller.text = state.userName.value;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 18),
          child: TextFormField(
            controller: _controller,
            key: const Key('accountView_userName_textField'),
            readOnly: state.status.isLoading,
            textInputAction: TextInputAction.next,
            onChanged: (userName) => context
                .read<AccountBloc>()
                .add(AccountUserNameChanged(userName)),
            decoration: const InputDecoration(labelText: 'User Name'),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _UserCompanyNameTextField extends StatefulWidget {
  const _UserCompanyNameTextField();

  @override
  State<_UserCompanyNameTextField> createState() =>
      _UserCompanyNameTextFieldState();
}

class _UserCompanyNameTextFieldState extends State<_UserCompanyNameTextField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          _controller.text = state.companyName.value;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 18),
          child: TextFormField(
            controller: _controller,
            key: const Key('accountView_companyName_textField'),
            readOnly: state.status.isLoading,
            onChanged: (companyName) => context.read<AccountBloc>().add(
                  AccountCompanyNameChanged(companyName),
                ),
            decoration: const InputDecoration(
              labelText: 'Company Name',
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _UpdateUserButton extends StatelessWidget {
  const _UpdateUserButton();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AccountBloc>().state;

    return ElevatedButton(
      key: const Key('accountView_update_button'),
      onPressed: state.status.isLoading || !state.valid
          ? null
          : () => context.read<AccountBloc>().add(
                AccountUserUpdated(
                  user: User(
                    id: state.user.id,
                    userName: state.userName.value,
                    companyName: state.companyName.value,
                  ),
                ),
              ),
      child: Text(state.status.isLoading ? 'Saving...' : 'Update'),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (AccountBloc bloc) => bloc.state.status == AccountStatus.loading,
    );

    return OutlinedButton(
      key: const Key('accountView_signOut_button'),
      onPressed: isLoading
          ? null
          : () => context.read<AccountBloc>().add(AccountSignedOut()),
      child: const Text('Sign Out'),
    );
  }
}
