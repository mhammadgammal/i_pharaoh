part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class SignUpSuccessState extends RegisterState {}

final class SignUpFailureState extends RegisterState {}

final class SignUpWithGoogleLoading extends RegisterState {}

final class PasswordVisibilityChanged extends RegisterState {}
