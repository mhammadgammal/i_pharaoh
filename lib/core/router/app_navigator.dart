import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/router/router_helper.dart';

abstract class AppNavigator {
  static Future<dynamic> navigateToBoarding(context) =>
      Navigator.pushNamed(context, RouterHelper.boarding);

  static Future<dynamic> navigateToLogin(context) =>
      Navigator.pushNamed(context, RouterHelper.signIn);

  static Future<dynamic> navigateAndReplaceToSignUp(context) =>
      Navigator.pushReplacementNamed(context, RouterHelper.signUp);

  static Future<dynamic> navigateReplacementToLogin(context) =>
      Navigator.pushReplacementNamed(context, RouterHelper.signIn);

  static Future<dynamic> navigateToSignUp(context) =>
      Navigator.pushNamed(context, RouterHelper.signUp);

  static Future<dynamic> navigateToHome(BuildContext context) =>
      Navigator.pushReplacementNamed(context, RouterHelper.home);

  static navigateToCamera(BuildContext context) =>
      Navigator.pushReplacementNamed(context, RouterHelper.camera);

  static Future<dynamic> navigateToShow(BuildContext context, String imgPath) =>
      Navigator.pushNamed(context, RouterHelper.show, arguments: imgPath);
  }
