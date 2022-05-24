import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:supabase_auth_repository/supabase_auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._supabaseAuthRepository) : super(const LoginState()) {
    on<LoginEventSignIn>(_onSignIn);
    on<LoginEventSignOut>(_onSignOut);
    on<LoginEmailChanged>(_onEmailChanged);
  }

  final SupabaseAuthRepository _supabaseAuthRepository;

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        valid: Formz.validate([email]),
      ),
    );
  }

  Future<void> _onSignIn(
    LoginEventSignIn event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _supabaseAuthRepository.signIn(
        email: event.email,
        isWeb: event.isWeb,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error);
    }
  }

  Future<void> _onSignOut(
    LoginEventSignOut event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _supabaseAuthRepository.signOut();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error);
    }
  }
}
