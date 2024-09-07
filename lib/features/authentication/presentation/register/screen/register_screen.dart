import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/router/app_navigator.dart';
import 'package:i_pharaoh/core/theme/app_images.dart';
import 'package:i_pharaoh/core/utils/localization/app_localization.dart';
import 'package:i_pharaoh/core/utils/localization/app_strings.dart';
import 'package:i_pharaoh/core/utils/screen_util/screen_utils.dart';
import 'package:i_pharaoh/core/widgets/default_form_field.dart';
import 'package:i_pharaoh/core/widgets/phone_number_input_widget.dart';
import 'package:i_pharaoh/features/authentication/presentation/register/cubit/register_cubit.dart';
import 'package:i_pharaoh/features/authentication/presentation/widgets/authentication_button.dart';
import 'package:i_pharaoh/features/authentication/presentation/widgets/continue_with_google.dart';
import 'package:i_pharaoh/features/authentication/presentation/widgets/custom_dashed_line.dart';

import '../../../../../core/theme/app_colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      builder: (context, state) {
        var cubit = context.read<RegisterCubit>();
        return Scaffold(
            body: Container(
          alignment: Alignment.center,
          padding: EdgeInsetsDirectional.only(
            start: ScreenUtils.getScreenWidth(context) * 0.05,
            end: ScreenUtils.getScreenWidth(context) * 0.05,
            top: ScreenUtils.getScreenHeight(context) * 0.05,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.loginBackground),
                fit: BoxFit.fitWidth),
          ),
          child: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ScreenUtils.getScreenHeight(context) * 0.08,
                  ),
                  Text(
                    AppLocalizations.of(context).translate(AppStrings.registerQuote),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: DefaultFormFiled(
                              controller: cubit.firstNameController,
                              inputType: TextInputType.name,
                              fieldLabel: AppLocalizations.of(context)
                                  .translate(AppStrings.firstName),
                              icon: const Icon(Icons.person,
                                  color: AppColors.papyrusCream),
                              focusNode: cubit.firstNameNode,
                              onSubmit: (_) =>
                                  cubit.lastNameNode.requestFocus(),
                              validate: (value) =>
                                  cubit.validateFirstName(context, value))),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: DefaultFormFiled(
                              controller: cubit.lastNameController,
                              inputType: TextInputType.name,
                              fieldLabel: AppLocalizations.of(context)
                                  .translate(AppStrings.lastName),
                              icon: const Icon(Icons.person,
                                  color: AppColors.papyrusCream),
                              focusNode: cubit.lastNameNode,
                              onSubmit: (_) => cubit.phoneNode.requestFocus(),
                              validate: (value) =>
                                  cubit.validateLastName(context, value))),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  PhoneNumberInputWidget(
                    phoneNode: cubit.phoneNode,
                    phoneController: cubit.phoneController,
                    selectorNavigator: cubit.selectorNavigator,
                    onEditComplete: () =>
                        FocusScope.of(context).requestFocus(cubit.emailNode),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  DefaultFormFiled(
                      controller: cubit.emailController,
                      focusNode: cubit.emailNode,
                      inputType: TextInputType.emailAddress,
                      fieldLabel: AppLocalizations.of(context)
                          .translate(AppStrings.emailAddress),
                      icon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.papyrusCream,
                      ),
                      onSubmit: (_) => cubit.passwordNode.requestFocus(),
                      validate: (value) => cubit.validateEmail(context, value)),
                  const SizedBox(
                    height: 30.0,
                  ),
                  DefaultFormFiled(
                      controller: cubit.passwordController,
                      focusNode: cubit.passwordNode,
                      inputType: TextInputType.visiblePassword,
                      maxLines: 1,
                      obSecure: cubit.isSecured,
                      suffixIcon: IconButton(
                        onPressed: () => cubit.onPasswordVisibilityChanged(),
                        icon: Icon(
                          cubit.isSecured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.papyrusCream,
                        ),
                      ),
                      fieldLabel: AppLocalizations.of(context)
                          .translate(AppStrings.password),
                      icon: const Icon(
                        Icons.lock_outlined,
                        color: AppColors.papyrusCream,
                      ),
                      onSubmit: (_) => cubit.confirmPasswordNode.requestFocus(),
                      validate: (value) =>
                          cubit.validatePassword(context, value)),
                  const SizedBox(
                    height: 30.0,
                  ),
                  DefaultFormFiled(
                      controller: cubit.confirmPasswordController,
                      focusNode: cubit.confirmPasswordNode,
                      inputType: TextInputType.visiblePassword,
                      maxLines: 1,
                      obSecure: cubit.isSecured,
                      suffixIcon: IconButton(
                        onPressed: () => cubit.onPasswordVisibilityChanged(),
                        icon: Icon(
                          cubit.isSecured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.papyrusCream,
                        ),
                      ),
                      fieldLabel: AppLocalizations.of(context)
                          .translate(AppStrings.confirmPassword),
                      icon: const Icon(
                        Icons.lock_outlined,
                        color: AppColors.papyrusCream,
                      ),
                      onSubmit: (_) => cubit.signUp(),
                      validate: (value) =>
                          cubit.validateConfirmPassword(context, value)),
                  const SizedBox(
                    height: 50.0,
                  ),
                  AuthenticationButton(
                    isLoading: false,
                    title: AppLocalizations.of(context)
                        .translate(AppStrings.signUp),
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.signUp();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CustomDashedLine(
                          color: Colors.blueGrey,
                        ),
                      )),
                      Text(
                        AppLocalizations.of(context)
                            .translate(AppStrings.or),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 17.0,
                            ),
                      ),
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CustomDashedLine(
                          color: Colors.blueGrey,
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const ContinueWithGoogle(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate(AppStrings.alreadyHaveAcc),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15.0,
                            decoration: TextDecoration.underline),
                      ),
                      TextButton(
                        onPressed: () =>
                            AppNavigator.navigateReplacementToLogin(context),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate(AppStrings.loginNow),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 15.0),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
      },
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          AppNavigator.navigateToCamera(context);
        }
      },
    );
  }
}
