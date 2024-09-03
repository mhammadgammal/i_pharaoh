import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/base_use_case/base_parameter.dart';
import 'package:i_pharaoh/features/authentication/domain/use_case/sign_in_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SignInUseCase _signInUseCase;

  LoginCubit(this._signInUseCase) : super(LoginInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  bool isSecured = true;

  Future<void> signIn() async {
    emit(LoginLoading());
    var result = await _signInUseCase.perform(LoginParameter(
        email: emailController.text, password: passwordController.text));

    result.fold((user) {
      log(user.email);
      emit(LoginSuccessState());
    }, (err) {
      log('Error Authenticating: $err');
      emit(LoginFailureState());
    });
  }

  void onPasswordVisibilityChanged() {
    isSecured = !isSecured;
    emit(PasswordVisibilityChanged());
  }

  String? validateEmail(String? value) => value == null || value.isEmpty
      ? 'Email shouldn\'t be empty'
      : !value.contains('@')
          ? 'email should contains "@"'
          : null;

  String? validatePassword(String? value) => value == null || value.isEmpty
      ? 'Password shouldn\'t be empty'
      : value.length < 8
          ? 'Password should at least be 8 characters'
          : null;
}
