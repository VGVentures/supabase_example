// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_database_repository/supabase_database_repository.dart';

void main() {
  group('SupabaseDatabaseRepository', () {
    test('can be instantiated', () {
      expect(SupabaseDatabaseRepository(), isNotNull);
    });
  });
}
