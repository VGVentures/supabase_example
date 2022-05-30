part of 'account_bloc.dart';

class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetUserInformation extends AccountEvent {
  const GetUserInformation();
  @override
  List<Object> get props => [];
}

class UpdateUser extends AccountEvent {
  const UpdateUser({
    required this.user,
  });
  final SupabaseUser user;

  @override
  List<Object> get props => [user];
}

class AccountUserNameChanged extends AccountEvent {
  const AccountUserNameChanged(this.userName);

  final String userName;

  @override
  List<Object> get props => [userName];
}

class AccountCompanyNameChanged extends AccountEvent {
  const AccountCompanyNameChanged(this.companyName);

  final String companyName;

  @override
  List<Object> get props => [companyName];
}

class AccountEventSignOut extends AccountEvent {}
