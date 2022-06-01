// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_repository/supabase_auth_repository.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:supabase_database_repository/supabase_database_repository.dart';
import 'package:very_good_supabase/account/account.dart';

class MockSuapabaseDatabaseRepository extends Mock
    implements SupabaseDatabaseRepository {}

class MockSupabaseAuthRepository extends Mock
    implements SupabaseAuthRepository {}

class FakeUser extends Fake implements SupabaseUser {
  @override
  final String userName = 'username';
  @override
  final String companyName = 'companyName';
}

void main() {
  late SupabaseDatabaseRepository supabaseDatabaseRepository;
  late SupabaseAuthRepository supabaseAuthRepository;
  late SupabaseUser user;

  const invalidUserName = UserName.dirty();

  const validUserNameString = 'user name';
  const validUserName = UserName.dirty(validUserNameString);

  const invalidCompanyName = CompanyName.dirty();

  const validCompanyNameString = 'company name';
  const validCompanyName = CompanyName.dirty(validCompanyNameString);

  setUp(() {
    supabaseDatabaseRepository = MockSuapabaseDatabaseRepository();
    supabaseAuthRepository = MockSupabaseAuthRepository();
    user = FakeUser();
  });

  test('initial state is AccountState', () {
    expect(
      AccountBloc(
        supabaseDatabaseRepository,
        supabaseAuthRepository,
      ).state,
      AccountState(),
    );
  });

  group('AccountUserNameChanged', () {
    blocTest<AccountBloc, AccountState>(
      'emits [invalid] and status [AccountStatus.edit] when edit '
      'the textField and user name is invalid',
      build: () => AccountBloc(
        supabaseDatabaseRepository,
        supabaseAuthRepository,
      ),
      act: (bloc) => bloc.add(AccountUserNameChanged('')),
      expect: () => const <AccountState>[
        AccountState(
          status: AccountStatus.edit,
          userName: invalidUserName,
        ),
      ],
    );

    blocTest<AccountBloc, AccountState>(
      'emits [valid] and status [AccountStatus.edit] when user edits '
      'the textField and user name and company name are valid',
      seed: () => AccountState(
        status: AccountStatus.success,
        companyName: validCompanyName,
        userName: validUserName,
        valid: true,
      ),
      build: () => AccountBloc(
        supabaseDatabaseRepository,
        supabaseAuthRepository,
      ),
      act: (bloc) => bloc.add(AccountUserNameChanged(validUserNameString)),
      expect: () => const <AccountState>[
        AccountState(
          status: AccountStatus.edit,
          userName: validUserName,
          companyName: validCompanyName,
          valid: true,
        ),
      ],
    );
  });

  group('AccountCompanyNameChanged', () {
    blocTest<AccountBloc, AccountState>(
      'emits [invalid] and status [AccountStatus.edit] when edit '
      'the textField and company name is invalid',
      build: () => AccountBloc(
        supabaseDatabaseRepository,
        supabaseAuthRepository,
      ),
      act: (bloc) => bloc.add(AccountCompanyNameChanged('')),
      expect: () => const <AccountState>[
        AccountState(
          status: AccountStatus.edit,
          companyName: invalidCompanyName,
        ),
      ],
    );
  });

  group('AccountUserInformationFetched', () {
    blocTest<AccountBloc, AccountState>(
      'emits [AccountStatus.loading, AccountStatus.success] '
      'when get user information succeeds',
      setUp: () {
        when(
          () => supabaseDatabaseRepository.getUserProfile(),
        ).thenAnswer((_) async => user);
      },
      build: () => AccountBloc(
        supabaseDatabaseRepository,
        supabaseAuthRepository,
      ),
      act: (bloc) => bloc.add(AccountUserInformationFetched()),
      expect: () => <AccountState>[
        AccountState(status: AccountStatus.loading),
        AccountState(
          status: AccountStatus.success,
          user: user,
          userName: UserName.dirty(user.userName),
          companyName: CompanyName.dirty(user.companyName),
        )
      ],
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountStatus.loading, AccountStatus.error] '
      'when get user information fails',
      setUp: () {
        when(
          () => supabaseDatabaseRepository.getUserProfile(),
        ).thenThrow(Exception());
      },
      build: () => AccountBloc(
        supabaseDatabaseRepository,
        supabaseAuthRepository,
      ),
      act: (bloc) => bloc.add(AccountUserInformationFetched()),
      expect: () => <AccountState>[
        AccountState(status: AccountStatus.loading),
        AccountState(status: AccountStatus.error)
      ],
    );
  });

  group('AccountUserUpdated', () {
    blocTest<AccountBloc, AccountState>(
      'emits [AccountStatus.loading, AccountStatus.update] '
      'when update user succeeds',
      setUp: () {
        when(
          () => supabaseDatabaseRepository.updateUser(user: user),
        ).thenAnswer((_) async {});
      },
      build: () => AccountBloc(
        supabaseDatabaseRepository,
        supabaseAuthRepository,
      ),
      act: (bloc) => bloc.add(AccountUserUpdated(user: user)),
      expect: () => <AccountState>[
        AccountState(status: AccountStatus.loading),
        AccountState(status: AccountStatus.update)
      ],
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountStatus.loading, AccountStatus.error] '
      'when update user fails',
      setUp: () {
        when(
          () => supabaseDatabaseRepository.updateUser(user: user),
        ).thenThrow(Exception());
      },
      build: () => AccountBloc(
        supabaseDatabaseRepository,
        supabaseAuthRepository,
      ),
      act: (bloc) => bloc.add(AccountUserUpdated(user: user)),
      expect: () => <AccountState>[
        AccountState(status: AccountStatus.loading),
        AccountState(status: AccountStatus.error)
      ],
    );

    group('AccountSignedOut', () {
      blocTest<AccountBloc, AccountState>(
        'emits [AccountStatus.loading, AccountStatus.success] '
        'when sign out succeeds',
        setUp: () {
          when(() => supabaseAuthRepository.signOut()).thenAnswer((_) async {});
        },
        build: () => AccountBloc(
          supabaseDatabaseRepository,
          supabaseAuthRepository,
        ),
        act: (bloc) => bloc.add(
          AccountSignedOut(),
        ),
        expect: () => <AccountState>[
          AccountState(status: AccountStatus.loading),
          AccountState(status: AccountStatus.success)
        ],
      );

      blocTest<AccountBloc, AccountState>(
        'emits [AccountStatus.loading, AccountStatus.error] '
        'when sign out fails',
        setUp: () {
          when(() => supabaseAuthRepository.signOut()).thenThrow(Exception());
        },
        build: () => AccountBloc(
          supabaseDatabaseRepository,
          supabaseAuthRepository,
        ),
        act: (bloc) => bloc.add(
          AccountSignedOut(),
        ),
        expect: () => <AccountState>[
          AccountState(status: AccountStatus.loading),
          AccountState(status: AccountStatus.error)
        ],
      );
    });
  });
}
