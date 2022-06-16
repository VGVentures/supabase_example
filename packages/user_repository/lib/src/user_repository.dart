import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';

/// {@template user_repository}
/// A package which manages the user domain.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required SupabaseAuthClient authClient,
    required SupabaseDatabaseClient databaseClient,
  })  : _authClient = authClient,
        _databaseClient = databaseClient;

  final SupabaseAuthClient _authClient;
  final SupabaseDatabaseClient _databaseClient;

  /// Method to get user information from profiles database.
  Future<SupabaseUser> getUserProfile() => _databaseClient.getUserProfile();

  /// Method to update user information on profiles database.
  Future<void> updateUser({required SupabaseUser user}) {
    return _databaseClient.updateUser(user: user);
  }

  /// Method to do signIn.
  Future<void> signIn({required String email, required bool isWeb}) async {
    return _authClient.signIn(email: email, isWeb: isWeb);
  }

  /// Method to do signOut.
  Future<void> signOut() async => _authClient.signOut();
}
