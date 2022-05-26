import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/// {@template supabase_user}
/// Supabase user model
/// {@endtemplate}
part 'supabase_user.g.dart';

@JsonSerializable()
class SupabaseUser extends Equatable {
  /// {@macro supabase_user}
  const SupabaseUser({
    String? id,
    required this.userName,
    required this.companyName,
  }) : id = id ?? '';

  /// Id of the user.
  final String id;

  /// Name of the supabase user.
  @JsonKey(name: 'username')
  final String userName;

  /// Company name of the supabase user.
  @JsonKey(name: 'companyname')
  final String companyName;

  @override
  List<Object> get props => [id, userName, companyName];

  /// Empty Supabase object.
  static const empty = SupabaseUser(
    userName: '',
    companyName: '',
  );

  /// Connect the generated [_$SupabaseUserFromJson] function to the `fromJson`
  /// factory.
  factory SupabaseUser.fromJson(Map<String, dynamic> json) =>
      _$SupabaseUserFromJson(json);

  /// Connect the generated [_$SupabaseUserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SupabaseUserToJson(this);
}
