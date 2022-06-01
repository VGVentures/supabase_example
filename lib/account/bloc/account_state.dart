part of 'account_bloc.dart';

enum AccountStatus { initial, update, success, error, loading, edit }

extension AccountStatusX on AccountStatus {
  bool get isInitial => this == AccountStatus.initial;
  bool get isSuccess => this == AccountStatus.success;
  bool get isUpdate => this == AccountStatus.update;
  bool get isError => this == AccountStatus.error;
  bool get isLoading => this == AccountStatus.loading;
  bool get isEditing => this == AccountStatus.edit;
}

class AccountState extends Equatable {
  const AccountState({
    SupabaseUser? user,
    this.valid = false,
    this.userName = const UserName.pure(),
    this.companyName = const CompanyName.pure(),
    this.status = AccountStatus.initial,
  }) : user = user ?? SupabaseUser.empty;

  final UserName userName;
  final CompanyName companyName;
  final SupabaseUser user;
  final bool valid;
  final AccountStatus status;

  @override
  List<Object> get props => [
        user,
        companyName,
        userName,
        status,
        valid,
      ];

  AccountState copyWith({
    UserName? userName,
    CompanyName? companyName,
    SupabaseUser? user,
    bool? valid,
    AccountStatus? status,
  }) {
    return AccountState(
      userName: userName ?? this.userName,
      companyName: companyName ?? this.companyName,
      user: user ?? this.user,
      valid: valid ?? this.valid,
      status: status ?? this.status,
    );
  }
}
