import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/router/router_helper.dart';
import 'package:i_pharaoh/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:i_pharaoh/features/authentication/presentation/login/screen/login_screen.dart';
import 'package:i_pharaoh/features/boarding/presentation/on_boarding_screen.dart';

import '../di/di.dart';

abstract class AppRouter {
  static final Map<String, WidgetBuilder> generateRoute = {
    RouterHelper.boarding: (_) => OnBoardingScreen(),
    RouterHelper.signIn: (_) => BlocProvider(
          create: (_) => LoginCubit(sl.get()),
          child: const LoginScreen(),
        ),
    
  };
}
