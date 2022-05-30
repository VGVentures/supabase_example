import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:supabase_auth_repository/supabase_auth_repository.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:supabase_database_repository/supabase_database_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(
    this._supabaseDatabaseRepository,
    this._supabaseAuthRepository,
  ) : super(const AccountState()) {
    on<AccountGotUserInformation>(_onGetUserInformation);
    on<AccountUserUpdated>(_onUpdateUser);
    on<AccountSignedOut>(_onSignOut);
    on<AccountUserNameChanged>(_onUserNameChanged);
    on<AccountCompanyNameChanged>(_onCompanyNameChanged);
  }

  final SupabaseDatabaseRepository _supabaseDatabaseRepository;
  final SupabaseAuthRepository _supabaseAuthRepository;

  Future<void> _onGetUserInformation(
    AccountGotUserInformation event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      final user = await _supabaseDatabaseRepository.getUserProfile();
      emit(
        state.copyWith(
          status: AccountStatus.success,
          user: user,
          userName: UserName.dirty(user.userName),
          companyName: CompanyName.dirty(user.companyName),
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AccountStatus.error));
      addError(error);
    }
  }

  Future<void> _onUpdateUser(
    AccountUserUpdated event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      await _supabaseDatabaseRepository.updateUser(user: event.user);
      emit(state.copyWith(status: AccountStatus.update, valid: false));
    } catch (error) {
      emit(state.copyWith(status: AccountStatus.error));
      addError(error);
    }
  }

  Future<void> _onSignOut(
    AccountSignedOut event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      await _supabaseAuthRepository.signOut();
      emit(state.copyWith(status: AccountStatus.success));
    } catch (error) {
      emit(state.copyWith(status: AccountStatus.error));
      addError(error);
    }
  }

  Future<void> _onUserNameChanged(
    AccountUserNameChanged event,
    Emitter<AccountState> emit,
  ) async {
    final userName = UserName.dirty(event.userName);
    emit(
      state.copyWith(
        status: AccountStatus.edit,
        userName: userName,
        valid: Formz.validate([userName, state.companyName]),
      ),
    );
  }

  Future<void> _onCompanyNameChanged(
    AccountCompanyNameChanged event,
    Emitter<AccountState> emit,
  ) async {
    final companyName = CompanyName.dirty(event.companyName);
    emit(
      state.copyWith(
        status: AccountStatus.edit,
        companyName: companyName,
        valid: Formz.validate([companyName, state.userName]),
      ),
    );
  }
}
