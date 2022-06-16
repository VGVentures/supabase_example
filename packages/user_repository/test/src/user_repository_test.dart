// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:user_repository/user_repository.dart';

class MockSupabaseAuthClient extends Mock implements SupabaseAuthClient {}

void main() {
  late SupabaseAuthClient supabaseAuthClient;
  late UserRepository userRepository;
  const email = 'test@test.com';

  setUp(() {
    supabaseAuthClient = MockSupabaseAuthClient();
    userRepository = UserRepository(
      authClient: supabaseAuthClient,
    );
  });
  group('UserRepository', () {
    test('can be instantiated', () {
      expect(
        UserRepository(authClient: supabaseAuthClient),
        isNotNull,
      );
    });

    group('SignIn', () {
      test('with email completes', () async {
        when(
          () => supabaseAuthClient.signIn(email: email, isWeb: false),
        ).thenAnswer((_) async {});

        expect(
          userRepository.signIn(email: email, isWeb: false),
          completes,
        );
      });
    });

    group('SignOut', () {
      test('completes', () async {
        when(() => supabaseAuthClient.signOut()).thenAnswer((_) async {});
        expect(userRepository.signOut(), completes);
      });
    });
  });
}
