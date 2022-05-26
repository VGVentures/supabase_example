import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppAuthenticated>(_onAppAuthenticated);
    on<AppUnauthenticated>(_onLogoutRequest);
  }

  Future<void> _onAppAuthenticated(
    AppAuthenticated event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.authenticated));
  }

  Future<void> _onLogoutRequest(
    AppUnauthenticated event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.unauthenticated));
  }
}
