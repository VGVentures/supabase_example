// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';

void main() {
  group('SupabaseAuthClient', () {
    test('can be instantiated', () {
      expect(SupabaseAuthClient(), isNotNull);
    });
  });
}
