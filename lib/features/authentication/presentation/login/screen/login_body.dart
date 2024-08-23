import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/theme/app_colors.dart';
import 'package:i_pharaoh/core/theme/app_strings.dart';
import 'package:i_pharaoh/core/widgets/default_form_field.dart';
import 'package:i_pharaoh/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:i_pharaoh/features/authentication/presentation/widgets/authentication_button.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 150.0, horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    AppStrings.welcome,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 65,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  DefaultFormFiled(
                      controller: cubit.emailController,
                      focusNode: cubit.emailNode,
                      inputType: TextInputType.emailAddress,
                      fieldLabel: AppStrings.emailAddress,
                      icon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.papyrusCream,
                      ),
                      onSubmit: (_) => cubit.passwordNode.requestFocus(),
                      validate: null),
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
                      fieldLabel: 'Password',
                      icon: const Icon(
                        Icons.lock_outlined,
                        color: AppColors.papyrusCream,
                      ),
                      onSubmit: (_) => cubit.signIn(),
                      validate: null),
                  const SizedBox(
                    height: 50.0,
                  ),
                  AuthenticationButton(
                    isLoading: state is LoginLoading,
                    title: AppStrings.signIn,
                    onPressed: () => cubit.signIn(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
