part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginFailureState extends LoginState {}

final class GoogleLoginLoading extends LoginState {}

final class PasswordVisibilityChanged extends LoginState {}
