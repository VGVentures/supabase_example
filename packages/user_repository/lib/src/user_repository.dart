import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:user_repository/user_repository.dart';

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

  /// Method to access the current user.
  Future<User> getUser() async {
    final supabaseUser = await _databaseClient.getUserProfile();
    return supabaseUser.toUser();
  }

  /// Method to update user information on profiles database.
  Future<void> updateUser({required User user}) {
    return _databaseClient.updateUser(user: user.toSupabaseUser());
  }

  /// Method to do signIn.
  Future<void> signIn({required String email, required bool isWeb}) async {
    return _authClient.signIn(email: email, isWeb: isWeb);
  }

  /// Method to do signOut.
  Future<void> signOut() async => _authClient.signOut();
}

extension on SupabaseUser {
  User toUser() {
    return User(
      id: id,
      userName: userName,
      companyName: companyName,
    );
  }
}

extension on User {
  SupabaseUser toSupabaseUser() {
    return SupabaseUser(
      id: id,
      userName: userName,
      companyName: companyName,
    );
  }
}
