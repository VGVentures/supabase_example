// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:supabase_database_repository/supabase_database_repository.dart';

class MockSupabaseRepository extends Mock implements SupabaseDatabaseClient {}

class MockUser extends Mock implements SupabaseUser {}

void main() {
  late SupabaseDatabaseClient supabaseDatabaseClient;
  late SupabaseDatabaseRepository supabaseDatabaseRepository;
  late SupabaseUser user;

  setUp(() {
    supabaseDatabaseClient = MockSupabaseRepository();
    user = MockUser();
    supabaseDatabaseRepository = SupabaseDatabaseRepository(
      supabaseDatabaseClient: supabaseDatabaseClient,
    );
  });

  group('SupabaseDatabaseRepository', () {
    test('can be instantiated', () {
      expect(
        SupabaseDatabaseRepository(
          supabaseDatabaseClient: supabaseDatabaseClient,
        ),
        isNotNull,
      );
    });

    group('GetUserProfile', () {
      test('returns a valid SupabaseUser', () async {
        when(
          () => supabaseDatabaseClient.getUserProfile(),
        ).thenAnswer((_) async => user);

        await supabaseDatabaseRepository.getUserProfile();
        verify(() => supabaseDatabaseClient.getUserProfile());
      });
    });

    group('UpdateUser', () {
      test('on Supabase database', () async {
        when(
          () => supabaseDatabaseClient.updateUser(user: user),
        ).thenAnswer((_) async {});

        await supabaseDatabaseRepository.updateUser(user: user);
        verify(() => supabaseDatabaseClient.updateUser(user: user));
      });
    });
  });
}
