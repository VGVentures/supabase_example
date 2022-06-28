// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';
import 'package:very_good_supabase/account/account.dart';

import '../../helpers/helpers.dart';

class MockAccountBloc extends MockBloc<AccountEvent, AccountState>
    implements AccountBloc {}

void main() {
  const updateUserButtonKey = Key('accountView_update_button');
  const signOutButtonKey = Key('accountView_signOut_button');

  const userNameInputKey = Key('accountView_userName_textField');
  const userName = 'user name';

  const companyNameInputKey = Key('accountView_companyName_textField');
  const companyName = 'company name';

  late AccountBloc accountBloc;

  setUpAll(() async {
    await initializeSupabase();
  });

  group('AccountView', () {
    setUp(() async {
      accountBloc = MockAccountBloc();
      when(() => accountBloc.state)
          .thenReturn(AccountState(status: AccountStatus.success));
    });

    testWidgets('show SnackBar when status is [AccountStatus.update]',
        (tester) async {
      whenListen(
        accountBloc,
        Stream.fromIterable(const <AccountState>[
          AccountState(status: AccountStatus.update),
        ]),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: accountBloc,
          child: const AccountView(),
        ),
      );
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });

    group('adds', () {
      testWidgets('AccountUserNameChanged when user name is changed',
          (tester) async {
        whenListen(
          accountBloc,
          Stream.fromIterable(const <AccountState>[
            AccountState(status: AccountStatus.edit),
            AccountState(
              status: AccountStatus.success,
              valid: true,
            ),
          ]),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: accountBloc,
            child: const AccountView(),
          ),
        );
        await tester.enterText(find.byKey(userNameInputKey), userName);
        await tester.pumpAndSettle();

        verify(() => accountBloc.add(AccountUserNameChanged(userName)))
            .called(1);
      });

      testWidgets('AccountCompanyNameChanged when company name is changed',
          (tester) async {
        whenListen(
          accountBloc,
          Stream.fromIterable(const <AccountState>[
            AccountState(status: AccountStatus.edit),
            AccountState(
              status: AccountStatus.success,
              valid: true,
            ),
          ]),
        );
        await tester.pumpApp(
          BlocProvider.value(
            value: accountBloc,
            child: const AccountView(),
          ),
        );
        await tester.enterText(find.byKey(companyNameInputKey), companyName);
        await tester.pump();

        verify(() => accountBloc.add(AccountCompanyNameChanged(companyName)))
            .called(1);
      });

      testWidgets('UpdateUser when UpdateUserButton is pressed',
          (tester) async {
        final user = User(
          id: 'id',
          userName: 'userName',
          companyName: 'companyName',
        );
        when(() => accountBloc.state).thenReturn(
          AccountState(
            user: user,
            status: AccountStatus.success,
            companyName: CompanyName.dirty('companyName'),
            userName: UserName.dirty('userName'),
            valid: true,
          ),
        );
        await tester.pumpApp(
          BlocProvider.value(
            value: accountBloc,
            child: AccountView(),
          ),
        );
        await tester.ensureVisible(find.byKey(updateUserButtonKey));
        await tester.tap(find.byKey(updateUserButtonKey));
        await tester.pumpAndSettle();

        verify(
          () => accountBloc.add(
            AccountUserUpdated(
              user: User(
                id: user.id,
                userName: 'userName',
                companyName: 'companyName',
              ),
            ),
          ),
        ).called(1);
      });

      testWidgets('SignOut when SignOutButton is pressed', (tester) async {
        await tester.pumpApp(
          BlocProvider.value(
            value: accountBloc,
            child: AccountView(),
          ),
        );
        await tester.ensureVisible(find.byKey(signOutButtonKey));
        await tester.tap(find.byKey(signOutButtonKey));
        await tester.pumpAndSettle();

        verify(
          () => accountBloc.add(AccountSignedOut()),
        ).called(1);
      });
    });
  });
}
