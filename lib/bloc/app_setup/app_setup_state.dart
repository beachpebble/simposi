part of 'app_setup_cubit.dart';

@immutable
abstract class AppSetupState {}

class AppSetupInitial extends AppSetupState {}

class AppSetupLoading extends AppSetupState {}

class AppSetupLoaded extends AppSetupState {}

class AppSetupError extends AppSetupState {
  final dynamic error;

  AppSetupError(this.error);
}
