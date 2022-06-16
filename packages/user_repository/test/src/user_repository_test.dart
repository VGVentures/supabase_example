// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:user_repository/user_repository.dart';

class MockSupabaseAuthClient extends Mock implements SupabaseAuthClient {}

class MockSupabaseDatabaseClient extends Mock
    implements SupabaseDatabaseClient {}

void main() {
  late SupabaseAuthClient authClient;
  late SupabaseDatabaseClient databaseClient;
  late SupabaseUser supabaseUser;
  late User user;
  late UserRepository userRepository;
  const email = 'test@test.com';

  setUp(() {
    authClient = MockSupabaseAuthClient();
    databaseClient = MockSupabaseDatabaseClient();
    supabaseUser = SupabaseUser(
      id: 'id',
      userName: 'userName',
      companyName: 'companyName',
    );
    user = User(id: 'id', userName: 'userName', companyName: 'companyName');
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

    group('getUser', () {
      test('returns a valid user', () async {
        when(
          () => databaseClient.getUserProfile(),
        ).thenAnswer((_) async => supabaseUser);

        expect(userRepository.getUser(), completion(equals(user)));
        verify(() => databaseClient.getUserProfile()).called(1);
      });
    });

    group('updateUser', () {
      test('on Supabase database', () async {
        when(
          () => databaseClient.updateUser(user: supabaseUser),
        ).thenAnswer((_) async {});

        await userRepository.updateUser(user: user);
        verify(() => databaseClient.updateUser(user: supabaseUser)).called(1);
      });
    });

    group('signIn', () {
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

    group('signOut', () {
      test('completes', () async {
        when(() => authClient.signOut()).thenAnswer((_) async {});
        expect(userRepository.signOut(), completes);
      });
    });
  });
}
