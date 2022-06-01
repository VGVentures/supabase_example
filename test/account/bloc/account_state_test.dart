// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:very_good_supabase/account/account.dart';

class MockUser extends Mock implements SupabaseUser {}

void main() {
  late SupabaseUser user;
  const userName = UserName.dirty('userName');
  const companyName = CompanyName.dirty('companyName');

  setUp(() {
    user = MockUser();
  });

  group('AccountState', () {
    test('supports value comparisons', () {
      expect(AccountState(), AccountState());
    });

    test('returns same object when no properties are passed', () {
      expect(AccountState().copyWith(), AccountState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        AccountState().copyWith(status: AccountStatus.initial),
        AccountState(),
      );
    });

    test('returns object with updated userName when userName is passed', () {
      expect(
        AccountState().copyWith(userName: userName),
        AccountState(userName: userName),
      );
    });

    test('returns object with updated companyName when companyName is passed',
        () {
      expect(
        AccountState().copyWith(companyName: companyName),
        AccountState(companyName: companyName),
      );
    });

    test('returns object with updated user when user is passed', () {
      expect(
        AccountState().copyWith(user: user),
        AccountState(user: user),
      );
    });

    group('AccountStatusX', () {
      test('returns correct values for AccountStatus.isInitial', () {
        const status = AccountStatus.initial;
        expect(status.isInitial, isTrue);
        expect(status.isLoading, isFalse);
        expect(status.isSuccess, isFalse);
        expect(status.isError, isFalse);
        expect(status.isUpdate, isFalse);
        expect(status.isEditing, isFalse);
      });

      test('returns correct values for AccountStatus.isLoading', () {
        const status = AccountStatus.loading;
        expect(status.isInitial, isFalse);
        expect(status.isLoading, isTrue);
        expect(status.isSuccess, isFalse);
        expect(status.isError, isFalse);
        expect(status.isUpdate, isFalse);
        expect(status.isEditing, isFalse);
      });

      test('returns correct values for AccountStatus.isSuccess', () {
        const status = AccountStatus.success;
        expect(status.isInitial, isFalse);
        expect(status.isLoading, isFalse);
        expect(status.isSuccess, isTrue);
        expect(status.isError, isFalse);
        expect(status.isUpdate, isFalse);
        expect(status.isEditing, isFalse);
      });

      test('returns correct values for AccountStatus.isError', () {
        const status = AccountStatus.error;
        expect(status.isInitial, isFalse);
        expect(status.isLoading, isFalse);
        expect(status.isSuccess, isFalse);
        expect(status.isUpdate, isFalse);
        expect(status.isError, isTrue);
        expect(status.isEditing, isFalse);
      });

      test('returns correct values for AccountStatus.isUpdate', () {
        const status = AccountStatus.update;
        expect(status.isInitial, isFalse);
        expect(status.isLoading, isFalse);
        expect(status.isSuccess, isFalse);
        expect(status.isError, isFalse);
        expect(status.isUpdate, isTrue);
        expect(status.isEditing, isFalse);
      });

      test('returns correct values for AccountStatus.isUpdate', () {
        const status = AccountStatus.edit;
        expect(status.isInitial, isFalse);
        expect(status.isLoading, isFalse);
        expect(status.isSuccess, isFalse);
        expect(status.isError, isFalse);
        expect(status.isUpdate, isFalse);
        expect(status.isEditing, isTrue);
      });
    });
  });
}
