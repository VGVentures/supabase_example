part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginEventSignIn extends LoginEvent {
  const LoginEventSignIn({
    required this.email,
    required this.isWeb,
  });

  final String email;
  final bool isWeb;
}

class LoginEventSignOut extends LoginEvent {}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}
