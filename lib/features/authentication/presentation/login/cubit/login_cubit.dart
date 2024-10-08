import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/base_use_case/base_parameter.dart';
import 'package:i_pharaoh/core/helpers/cache/cache_helper.dart';
import 'package:i_pharaoh/core/helpers/cache/cache_keys.dart';
import 'package:i_pharaoh/core/utils/localization/app_localization.dart';
import 'package:i_pharaoh/core/utils/localization/app_strings.dart';
import 'package:i_pharaoh/features/authentication/domain/use_case/sign_in_use_case.dart';
import 'package:i_pharaoh/features/authentication/domain/use_case/sign_in_with_google_use_case.dart';

import '../../../../../core/di/di.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SignInUseCase _signInUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  LoginCubit(this._signInUseCase, this._signInWithGoogleUseCase)
      : super(LoginInitial());

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

  Future<void> signInWithGoogle() async {
    emit(GoogleLoginLoading());

    var authResult = await _signInWithGoogleUseCase.perform();

    authResult.fold((user) {
      sl<CacheHelper>().putString(CacheKeys.uid, user.uid);
      emit(LoginSuccessState());
    }, (err) => emit(LoginFailureState()));
  }

  void onPasswordVisibilityChanged() {
    isSecured = !isSecured;
    emit(PasswordVisibilityChanged());
  }

  String? validateEmail(BuildContext context, String? value) =>
      value == null || value.isEmpty
          ? AppLocalizations.of(context).translate(AppStrings.emailIsRequired)
          : !value.contains('@')
              ? AppStrings.invalidEmailAddress
              : null;

  String? validatePassword(BuildContext context, String? value) =>
      value == null || value.isEmpty
          ? AppLocalizations.of(context)
              .translate(AppStrings.passwordIsRequired)
          : value.length < 8
              ? AppStrings.passwordCharsIsNotValid
              : null;
}
