import 'package:equatable/equatable.dart';

/// {@template supabase_user}
/// Supabase user model
/// {@endtemplate}

class SupabaseUser extends Equatable {
  /// {@macro supabase_user}
  const SupabaseUser({
    required this.userName,
    required this.companyName,
  });

  /// Name of the supabase user.
  final String userName;

  /// Company name of the supabase user.
  final String companyName;

  @override
  List<Object> get props => [userName, companyName];

  /// Empty Supabase object.
  static const empty = SupabaseUser(
    userName: '',
    companyName: '',
  );
}
