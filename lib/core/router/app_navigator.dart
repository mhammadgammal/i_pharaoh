import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/router/router_helper.dart';

abstract class AppNavigator {
  static Future<dynamic> navigateToBoarding(context) =>
      Navigator.pushNamed(context, RouterHelper.boarding);

  static Future<dynamic> navigateToLogin(context) =>
      Navigator.pushNamed(context, RouterHelper.signIn);

  static Future<dynamic> navigateToSignUp(context) =>
      Navigator.pushNamed(context, RouterHelper.signUp);
}
