import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/router/router_helper.dart';
import 'package:i_pharaoh/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:i_pharaoh/features/authentication/presentation/login/screen/login_screen.dart';
import 'package:i_pharaoh/features/authentication/presentation/register/cubit/register_cubit.dart';
import 'package:i_pharaoh/features/authentication/presentation/register/screen/register_screen.dart';
import 'package:i_pharaoh/features/boarding/presentation/on_boarding_screen.dart';
import 'package:i_pharaoh/features/pick_photo/presentation/cubit/pick_photo_cubit.dart';
import 'package:i_pharaoh/features/pick_photo/presentation/screen/take_pic_screen.dart';
import 'package:i_pharaoh/features/show/presentation/cubit/show_cubit.dart';
import 'package:i_pharaoh/features/show/presentation/screen/show_screen.dart';

import '../di/di.dart';

abstract class AppRouter {
  static final Map<String, WidgetBuilder> generateRoute = {
    RouterHelper.boarding: (_) => OnBoardingScreen(),
    RouterHelper.signIn: (_) => BlocProvider(
          create: (_) => LoginCubit(sl.get(), sl.get()),
          child: const LoginScreen(),
        ),
    RouterHelper.signUp: (_) => BlocProvider(
          create: (_) => RegisterCubit(sl.get(), sl.get()),
          child: const RegisterScreen(),
        ),
    RouterHelper.camera: (_) => BlocProvider(
          create: (context) => PickPhotoCubit()..requestCameraPermission(),
          child: const TakePicScreen(),
        ),
    RouterHelper.show: (context) {
      final imgPath = ModalRoute.of(context)!.settings.arguments as String;
      log('ShowScreen: imgPath: $imgPath');
      return BlocProvider(
        create: (_) => ShowCubit()..predictImg(imgPath),
        child: const ShowScreen(),
      );
    },
  };
}
