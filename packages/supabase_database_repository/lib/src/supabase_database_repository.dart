import 'package:supabase_database_client/supabase_database_client.dart';

/// {@template supabase_database_repository}
/// Supabase database repository
/// {@endtemplate}
class SupabaseDatabaseRepository {
  /// {@macro supabase_database_repository}
  const SupabaseDatabaseRepository({
    required SupabaseDatabaseClient supabaseDatabaseClient,
  }) : _supabaseDatabaseClient = supabaseDatabaseClient;

  final SupabaseDatabaseClient _supabaseDatabaseClient;

  /// Method to get user information from profiles database.
  Future<SupabaseUser> getUserProfile() =>
      _supabaseDatabaseClient.getUserProfile();

  /// Method to update user information on profiles database.
  Future<void> updateUser({required SupabaseUser user}) =>
      _supabaseDatabaseClient.updateUser(user: user);
}
