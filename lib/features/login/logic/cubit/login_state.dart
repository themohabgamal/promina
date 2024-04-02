part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginLoadedState extends LoginState {}

final class LoginErrorState extends LoginState {}
