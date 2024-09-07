import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/router/app_navigator.dart';
import 'package:i_pharaoh/core/theme/app_images.dart';
import 'package:i_pharaoh/core/utils/localization/app_localization.dart';
import 'package:i_pharaoh/core/utils/localization/app_strings.dart';
import 'package:i_pharaoh/core/widgets/error_dialogue.dart';
import 'package:i_pharaoh/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:i_pharaoh/features/authentication/presentation/login/screen/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          AppNavigator.navigateToCamera(context);
        } else if (state is LoginFailureState) {
          showDialog(
              context: context,
              builder: (context) =>
                ErrorDialogue(errorMessage: AppLocalizations.of(context).translate(AppStrings.loginError)));
        }
      },
      child: Scaffold(
          body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.loginBackground),
              fit: BoxFit.fitWidth),
        ),
        child: const LoginBody(),
      )),
    );
  }
}
