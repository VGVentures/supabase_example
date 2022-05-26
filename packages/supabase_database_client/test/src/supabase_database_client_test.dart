// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_database_client/supabase_database_client.dart';

void main() {
  group('SupabaseDatabaseClient', () {
    test('can be instantiated', () {
      expect(SupabaseDatabaseClient(), isNotNull);
    });
  });
}
