import 'package:equatable/equatable.dart';

/// {@template user}
/// An object which represents a specific user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({required this.id, this.companyName = '', this.userName = ''});

  /// An empty user (unauthenticated).
  static const User empty = User(id: '');

  /// The user's id.
  final String id;

  /// The user's company name.
  final String companyName;

  /// The user's user name.
  final String userName;

  @override
  List<Object> get props => [id, companyName, userName];
}
