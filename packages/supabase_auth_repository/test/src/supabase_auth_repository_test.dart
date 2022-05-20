// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_auth_repository/supabase_auth_repository.dart';

void main() {
  group('SupabaseAuthRepository', () {
    test('can be instantiated', () {
      expect(SupabaseAuthRepository(), isNotNull);
    });
  });
}
