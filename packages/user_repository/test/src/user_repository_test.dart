// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:user_repository/user_repository.dart';

class MockSupabaseAuthClient extends Mock implements SupabaseAuthClient {}

class MockSupabaseDatabaseClient extends Mock
    implements SupabaseDatabaseClient {}

class FakeUser extends Fake implements SupabaseUser {}

void main() {
  late SupabaseAuthClient authClient;
  late SupabaseDatabaseClient databaseClient;
  late SupabaseUser user;
  late UserRepository userRepository;
  const email = 'test@test.com';

  setUp(() {
    authClient = MockSupabaseAuthClient();
    databaseClient = MockSupabaseDatabaseClient();
    user = FakeUser();
    userRepository = UserRepository(
      authClient: authClient,
      databaseClient: databaseClient,
    );
  });
  group('UserRepository', () {
    test('can be instantiated', () {
      expect(
        UserRepository(
          authClient: authClient,
          databaseClient: databaseClient,
        ),
        isNotNull,
      );
    });

    group('GetUserProfile', () {
      test('returns a valid SupabaseUser', () async {
        when(
          () => databaseClient.getUserProfile(),
        ).thenAnswer((_) async => user);

        expect(userRepository.getUserProfile(), completion(equals(user)));
        verify(() => databaseClient.getUserProfile()).called(1);
      });
    });

    group('UpdateUser', () {
      test('on Supabase database', () async {
        when(
          () => databaseClient.updateUser(user: user),
        ).thenAnswer((_) async {});

        await userRepository.updateUser(user: user);
        verify(() => databaseClient.updateUser(user: user)).called(1);
      });
    });

    group('SignIn', () {
      test('with email completes', () async {
        when(
          () => authClient.signIn(email: email, isWeb: false),
        ).thenAnswer((_) async {});

        expect(
          userRepository.signIn(email: email, isWeb: false),
          completes,
        );
      });
    });

    group('SignOut', () {
      test('completes', () async {
        when(() => authClient.signOut()).thenAnswer((_) async {});
        expect(userRepository.signOut(), completes);
      });
    });
  });
}
