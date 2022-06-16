import 'package:supabase_auth_client/supabase_auth_client.dart';

/// {@template user_repository}
/// A package which manages the user domain.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required SupabaseAuthClient authClient,
  }) : _authClient = authClient;

  final SupabaseAuthClient _authClient;

  /// Method to do signIn.
  Future<void> signIn({required String email, required bool isWeb}) async {
    return _authClient.signIn(email: email, isWeb: isWeb);
  }

  /// Method to do signOut.
  Future<void> signOut() async => _authClient.signOut();
}
