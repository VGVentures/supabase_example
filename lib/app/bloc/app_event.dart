part of 'app_bloc.dart';

class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppAuthenticated extends AppEvent {
  const AppAuthenticated();

  @override
  List<Object> get props => [];
}
