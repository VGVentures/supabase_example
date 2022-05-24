// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

      test('with an email throw SupabaseSignInFailure', () async {
        when(
          () => goTrueClient.signIn(
            email: any(named: 'email'),
            options: any(named: 'options'),
          ),
        ).thenThrow(Exception('oops'));

        expect(
          supabaseAuthClient.signIn(email: email, isWeb: false),
          throwsA(isA<SupabaseSignInFailure>()),
        );
      });
    });

    group('SignOut', () {
      test('on completes', () async {
        when(() => goTrueClient.signOut()).thenAnswer(
          (_) async => gotrueSessionResponse,
        );
        await supabaseAuthClient.signOut();
        expect(
          supabaseAuthClient.signOut(),
          completes,
        );
      });

      test('throw SupabaseSignOutFailure', () async {
        when(
          () => goTrueClient.signOut(),
        ).thenThrow(Exception('oops'));

        expect(
          supabaseAuthClient.signOut(),
          throwsA(isA<SupabaseSignOutFailure>()),
        );
      });
    });
  });
}
