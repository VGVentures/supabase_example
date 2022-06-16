// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}

class MockPostgrestFilterBuilder extends Mock
    implements PostgrestFilterBuilder {}

class MockPostgrestTransformBuilder extends Mock
    implements PostgrestTransformBuilder<dynamic> {}

class MockPostgrestBuilder extends Mock implements PostgrestBuilder<dynamic> {}

class FakeUser extends Fake implements User {
  @override
  String id = 'id';
}

class FakePostgrestResponse extends Fake implements PostgrestResponse<dynamic> {
  @override
  final Map<String, dynamic> data = <String, String>{
    'username': 'username',
    'companyname': 'companyName'
  };
}

class FakeUpdatePostgrestResponse extends Fake
    implements PostgrestResponse<dynamic> {
  @override
  final Map<String, dynamic> data = <String, String>{
    'id': 'id',
    'updated_at': 'updated_at',
    'username': 'username',
    'avatar_url': 'avatar_url',
    'website': 'website',
    'companyname': 'companyname',
  };
}

void main() {
  const tableName = 'account';

  late SupabaseClient supabaseClient;
  late GoTrueClient goTrueClient;
  late PostgrestResponse<dynamic> postgrestResponse;
  late PostgrestResponse<dynamic> updatePostgrestResponse;
  late SupabaseDatabaseClient supabaseDatabaseClient;
  late SupabaseQueryBuilder supabaseQueryBuilder;
  late SupabaseQueryBuilder updateSupabaseQueryBuilder;
  late PostgrestFilterBuilder selectPostgrestFilterBuilder;
  late PostgrestFilterBuilder eqPostgrestFilterBuilder;
  late PostgrestTransformBuilder<dynamic> postgrestTransformBuilder;
  late PostgrestBuilder<dynamic> upsertPostgrestBuilder;
  late User user;

  setUp(() {
    supabaseClient = MockSupabaseClient();
    goTrueClient = MockGoTrueClient();
    postgrestResponse = FakePostgrestResponse();
    supabaseQueryBuilder = MockSupabaseQueryBuilder();
    updateSupabaseQueryBuilder = MockSupabaseQueryBuilder();
    selectPostgrestFilterBuilder = MockPostgrestFilterBuilder();
    eqPostgrestFilterBuilder = MockPostgrestFilterBuilder();
    postgrestTransformBuilder = MockPostgrestTransformBuilder();
    user = FakeUser();
    upsertPostgrestBuilder = MockPostgrestBuilder();
    updatePostgrestResponse = FakeUpdatePostgrestResponse();

    when(() => supabaseClient.auth).thenReturn(goTrueClient);
    when(() => goTrueClient.currentUser).thenReturn(user);

    supabaseDatabaseClient = SupabaseDatabaseClient(
      supabaseClient: supabaseClient,
    );
  });

  group('SupabaseDatabaseClient', () {
    test('can be instantiated', () {
      expect(
        SupabaseDatabaseClient(supabaseClient: supabaseClient),
        isNotNull,
      );
    });
  });

  group('GetUserProfile', () {
    setUp(() {
      when(() => supabaseClient.from(tableName))
          .thenReturn(supabaseQueryBuilder);

      when(() => supabaseQueryBuilder.select())
          .thenAnswer((_) => selectPostgrestFilterBuilder);
      when(
        () => selectPostgrestFilterBuilder.eq('id', any<String>()),
      ).thenAnswer((_) => eqPostgrestFilterBuilder);

      when(
        () => eqPostgrestFilterBuilder.single(),
      ).thenAnswer((_) => postgrestTransformBuilder);
    });

    test('completes', () async {
      when(
        () => postgrestTransformBuilder.execute(),
      ).thenAnswer((_) async => postgrestResponse);

      expect(
        supabaseDatabaseClient.getUserProfile(),
        completes,
      );
    });

    test('throw an SupabaseUserInformationFailure error', () async {
      when(() => postgrestTransformBuilder.execute())
          .thenThrow(Exception('oops'));
      expect(
        supabaseDatabaseClient.getUserProfile(),
        throwsA(isA<SupabaseUserInformationFailure>()),
      );
    });
  });

  group('UpdateUser', () {
    late SupabaseUser supabaseUser;

    setUp(() {
      supabaseUser = SupabaseUser(
        userName: 'username',
        companyName: 'companyName',
      );
    });

    test('completes', () {
      when(() => supabaseClient.from(tableName))
          .thenReturn(updateSupabaseQueryBuilder);
      when(
        () => updateSupabaseQueryBuilder.upsert(any<dynamic>()),
      ).thenReturn(upsertPostgrestBuilder);
      when(() => upsertPostgrestBuilder.execute()).thenAnswer(
        (_) async => updatePostgrestResponse,
      );

      expect(
        supabaseDatabaseClient.updateUser(
          user: supabaseUser,
        ),
        completes,
      );
    });

    test('throw an SupabaseUpdateUserFailure error', () async {
      when(() => supabaseClient.from(tableName))
          .thenReturn(supabaseQueryBuilder);
      when(() => supabaseQueryBuilder.upsert(any<dynamic>()))
          .thenThrow(Exception('oops'));

      expect(
        supabaseDatabaseClient.updateUser(user: supabaseUser),
        throwsA(isA<SupabaseUpdateUserFailure>()),
      );
    });
  });
}
