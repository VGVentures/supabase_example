// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_database_client/src/models/models.dart';

void main() {
  group('SupabaseUser', () {
    test('supports value equality', () {
      final supabaseUserA = SupabaseUser(userName: 'A', companyName: 'B');
      final secondSupabaseUserA = SupabaseUser(userName: 'A', companyName: 'B');
      final supabaseUserB = SupabaseUser(userName: 'B', companyName: 'C');

      expect(supabaseUserA, equals(secondSupabaseUserA));
      expect(supabaseUserA, isNot(equals(supabaseUserB)));
    });
  });
}
