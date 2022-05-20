// ignore_for_file: prefer_const_constructors
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:test/test.dart';

void main() {
  group('SupabaseAuthClient', () {
    test('can be instantiated', () {
      expect(SupabaseAuthClient(), isNotNull);
    });
  });
}
