import 'package:supabase_auth_client/supabase_auth_client.dart';

/// {@template auth_repository}
/// Auth repository
/// {@endtemplate}
class AuthRepository {
  /// {@macro auth_repository}
  AuthRepository({
    required SupabaseAuthClient authClient,
  }) : _authClient = authClient;

  final SupabaseAuthClient _authClient;

  /// Method to do signIn.
  Future<void> signIn({
    required String email,
    required bool isWeb,
  }) async =>
      _authClient.signIn(email: email, isWeb: isWeb);

  /// Method to do signOut.
  Future<void> signOut() async => _authClient.signOut();
}
