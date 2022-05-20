// ignore_for_file: prefer_const_constructors

import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test/test.dart';

class FakeGotrueSessionResponse extends Fake implements GotrueSessionResponse {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  late SupabaseAuthClient supabaseAuthClient;
  late GotrueSessionResponse gotrueSessionResponse;
  late GoTrueClient goTrueClient;

  const email = 'test@test.com';

  setUp(() {
    gotrueSessionResponse = FakeGotrueSessionResponse();
    goTrueClient = MockGoTrueClient();
    supabaseAuthClient = SupabaseAuthClient(
      auth: goTrueClient,
    );
  });

  group('SupabaseAuthClient', () {
    test('can be instantiated', () {
      expect(
        SupabaseAuthClient(
          auth: goTrueClient,
        ),
        isNotNull,
      );
    });

    group('SignIn', () {
      test('with an email completes', () async {
        when(
          () => goTrueClient.signIn(
            email: any(named: 'email'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => gotrueSessionResponse,
        );

        expect(
          supabaseAuthClient.signIn(email: email, isWeb: false),
          completes,
        );
      });

      test('with an email throw an error', () async {
        when(
          () => goTrueClient.signIn(
            email: any(named: 'email'),
            options: any(named: 'options'),
          ),
        ).thenThrow(SupabaseSignInFailure('oops'));

        expect(
          supabaseAuthClient.signIn(email: email, isWeb: false),
          throwsA(isA<SupabaseSignInFailure>()),
        );
      });
    });

    group('SignOut', () {
      test('on Supabase completes', () async {
        when(() => goTrueClient.signOut()).thenAnswer(
          (_) async => gotrueSessionResponse,
        );
        await supabaseAuthClient.signOut();
        expect(
          supabaseAuthClient.signOut(),
          completes,
        );
      });

      test('on Supabase failure', () async {
        when(
          () => goTrueClient.signOut(),
        ).thenThrow(SupabaseSignOutFailure('oops'));

        expect(
          supabaseAuthClient.signOut(),
          throwsA(isA<SupabaseSignOutFailure>()),
        );
      });
    });
  });
}
