// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_auth_repository/supabase_auth_repository.dart';

class MockSupabaseAuthClient extends Mock implements SupabaseAuthClient {}

void main() {
  late SupabaseAuthClient supabaseAuthClient;
  late SupabaseAuthRepository supabaseAuthRepository;
  const email = 'test@test.com';

  setUp(() {
    supabaseAuthClient = MockSupabaseAuthClient();
    supabaseAuthRepository = SupabaseAuthRepository(
      authClient: supabaseAuthClient,
    );
  });
  group('SupabaseAuthRepository', () {
    test('can be instantiated', () {
      expect(
        SupabaseAuthRepository(
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

        await supabaseAuthRepository.signIn(email: email, isWeb: false);
        verify(
          () => supabaseAuthClient.signIn(email: email, isWeb: false),
        ).called(1);
      });
    });

    group('SignOut', () {
      test('on Supabase', () async {
        when(() => supabaseAuthClient.signOut()).thenAnswer((_) async {});

        await supabaseAuthRepository.signOut();
        verify(
          () => supabaseAuthClient.signOut(),
        ).called(1);
      });
    });
  });
}
