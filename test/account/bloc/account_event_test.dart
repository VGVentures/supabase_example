// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';
import 'package:very_good_supabase/account/account.dart';

class MockUser extends Mock implements User {}

void main() {
  late User user;
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
          AccountUserUpdated(user: user),
          AccountUserUpdated(user: user),
        );
      });
    });

    group('AccountEventSignOut', () {
      test('supports value comparisons', () {
        expect(
          AccountSignedOut(),
          AccountSignedOut(),
        );
      });
    });

    group('GetUserInformation', () {
      test('supports value comparisons', () {
        expect(
          AccountUserInformationFetched(),
          AccountUserInformationFetched(),
        );
      });
    });
  });
}
