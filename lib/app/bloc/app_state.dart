part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.unauthenticated,
  });

  final AppStatus status;

  @override
  List<Object> get props => [status];

  AppState copyWith({
    AppStatus? status,
  }) {
    return AppState(
      status: status ?? this.status,
    );
  }
}
