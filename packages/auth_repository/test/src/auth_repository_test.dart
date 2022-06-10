// ignore_for_file: prefer_const_constructors
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';

class MockSupabaseAuthClient extends Mock implements SupabaseAuthClient {}

void main() {
  late SupabaseAuthClient supabaseAuthClient;
  late AuthRepository authRepository;
  const email = 'test@test.com';

  setUp(() {
    supabaseAuthClient = MockSupabaseAuthClient();
    authRepository = AuthRepository(
      authClient: supabaseAuthClient,
    );
  });
  group('AuthRepository', () {
    test('can be instantiated', () {
      expect(
        AuthRepository(
          authClient: supabaseAuthClient,
        ),
        isNotNull,
      );
    });

    group('SignIn', () {
      test('with email', () async {
        when(
          () => supabaseAuthClient.signIn(email: email, isWeb: false),
        ).thenAnswer((_) async {});

        expect(
          authRepository.signIn(email: email, isWeb: false),
          completes,
        );
      });
    });

    group('SignOut', () {
      test('on Supabase', () async {
        when(() => supabaseAuthClient.signOut()).thenAnswer((_) async {});
        expect(authRepository.signOut(), completes);
      });
    });
  });
}
