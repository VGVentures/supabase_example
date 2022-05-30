// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:very_good_supabase/account/account.dart';

class MockUser extends Mock implements SupabaseUser {}

void main() {
  late SupabaseUser user;
  const userName = 'user name';
  const companyName = 'company name';

  setUp(() {
    user = MockUser();
  });

  group('AccountEvent', () {
    test('supports value comparisons', () {
      expect(
        AccountEvent(),
        AccountEvent(),
      );
    });
    group('AccountUserNameChanged', () {
      test('supports value comparisons', () {
        expect(
          AccountUserNameChanged(userName),
          AccountUserNameChanged(userName),
        );
        expect(
          AccountUserNameChanged(''),
          isNot(AccountUserNameChanged(userName)),
        );
      });
    });

    group('AccountCompanyNameChanged', () {
      test('supports value comparisons', () {
        expect(
          AccountCompanyNameChanged(companyName),
          AccountCompanyNameChanged(companyName),
        );
        expect(
          AccountCompanyNameChanged(''),
          isNot(AccountCompanyNameChanged(companyName)),
        );
      });
    });

    group('UpdateUser', () {
      test('supports value comparisons', () {
        expect(
          UpdateUser(user: user),
          UpdateUser(user: user),
        );
      });
    });

    group('AccountEventSignOut', () {
      test('supports value comparisons', () {
        expect(
          AccountEventSignOut(),
          AccountEventSignOut(),
        );
      });
    });

    group('GetUserInformation', () {
      test('supports value comparisons', () {
        expect(
          GetUserInformation(),
          GetUserInformation(),
        );
      });
    });
  });
}
