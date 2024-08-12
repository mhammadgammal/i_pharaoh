import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/widgets/default_form_field.dart';
import 'package:i_pharaoh/features/authentication/presentation/login/cubit/login_cubit.dart';

import '../../../../../core/di/di.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(sl.get()),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          var cubit = context.read<LoginCubit>();
          return Scaffold(
            body: Column(
              children: [
                DefaultFormFiled(
                    controller: cubit.emailController,
                    focusNode: cubit.emailNode,
                    inputType: TextInputType.emailAddress,
                    fieldLabel: 'Email',
                    icon: const Icon(Icons.email_outlined),
                    onSubmit: (_) => cubit.passwordNode.requestFocus(),
                    validate: null),
                DefaultFormFiled(
                    controller: cubit.passwordController,
                    focusNode: cubit.passwordNode,
                    inputType: TextInputType.visiblePassword,
                    maxLines: 1,
                    obSecure: true,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.visibility_off,
                        )),
                    fieldLabel: 'Password',
                    icon: const Icon(Icons.lock_outlined),
                    onSubmit: (_) => cubit.signIn(),
                    validate: null),
                ElevatedButton(
                  onPressed: () => cubit.signIn(),
                  child: const Text('Sign In'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
