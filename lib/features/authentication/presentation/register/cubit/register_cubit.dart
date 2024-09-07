import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/base_use_case/base_parameter.dart';
import 'package:i_pharaoh/core/utils/localization/app_localization.dart';
import 'package:i_pharaoh/core/utils/localization/app_strings.dart';
import 'package:i_pharaoh/features/authentication/domain/use_case/sign_up_use_case.dart';
import 'package:phone_form_field/phone_form_field.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SignUpUseCase _signUpUseCase;
  RegisterCubit(this._signUpUseCase) : super(RegisterInitial());

  bool isSecured = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final firstNameNode = FocusNode();
  final lastNameController = TextEditingController();
  final lastNameNode = FocusNode();
  final PhoneController phoneController = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.EG, nsn: ''));
  final CountrySelectorNavigator selectorNavigator =
      const CountrySelectorNavigator.page();
  final phoneNode = FocusNode();
  final countryController = TextEditingController();
  final countryNode = FocusNode();
  final emailController = TextEditingController();
  final emailNode = FocusNode();
  final passwordController = TextEditingController();
  final passwordNode = FocusNode();
  final confirmPasswordController = TextEditingController();
  final confirmPasswordNode = FocusNode();

  String? validateFirstName(BuildContext context, String? value) =>
      value != null && value.isEmpty
          ? AppLocalizations.of(context)
              .translate(AppStrings.firstNameIsReauired)
          : null;

  String? validateLastName(BuildContext context, String? value) =>
      value != null && value.isEmpty
          ? AppLocalizations.of(context)
              .translate(AppStrings.lastNameIsReauired)
          : null;

  String? validatePhone(BuildContext context, String? value) => value != null &&
          value.isEmpty
      ? AppLocalizations.of(context).translate(AppStrings.phoneNumberIsRequired)
      : null;

  String? validateCountry(BuildContext context, String? value) =>
      value != null && value.isEmpty
          ? AppLocalizations.of(context).translate(AppStrings.countryIsRequired)
          : null;

  String? validateEmail(BuildContext context, String? value) =>
      value != null && value.isEmpty
          ? AppLocalizations.of(context).translate(AppStrings.emailIsRequired)
          : value != null && !value.contains('@')
              ? AppStrings.invalidEmailAddress
              : null;

  String? validatePassword(BuildContext context, String? value) =>
      value != null && value.isEmpty
          ? AppLocalizations.of(context)
              .translate(AppStrings.passwordIsRequired)
          : value != null && value.length < 8
              ? AppStrings.passwordCharsIsNotValid
              : null;

  String? validateConfirmPassword(BuildContext context, String? value) =>
      value != null && value.isEmpty
          ? AppLocalizations.of(context)
              .translate(AppStrings.confirmPasswordIsRequired)
          : value != null && value != passwordController.text
              ? AppLocalizations.of(context)
                  .translate(AppStrings.invalidConfirmPassword)
              : null;

  void onPasswordVisibilityChanged() {
    isSecured = !isSecured;
    emit(PasswordVisibilityChanged());
  }

  Future<void> signUp() async {
    String phoneNumber =
        '+${phoneController.value.countryCode}${phoneController.value.nsn}';
    log(phoneNumber);

    var result = await _signUpUseCase.perform(RegisterParameter(
        name: '${firstNameController.text} ${lastNameController.text}',
        email: emailController.text,
        password: passwordController.text));

    result.fold((user) => emit(SignUpSuccessState()), (e) {
      log(e.toString());
      emit(SignUpFailureState());
    });
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();
    phoneController.dispose();
    countryController.dispose();
    phoneNode.dispose();
    countryNode.dispose();
    return super.close();
  }
}
