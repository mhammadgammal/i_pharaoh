import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/theme/app_colors.dart';

class AppTheme {
  static var lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
      foregroundColor: AppColors.papyrusCream,
    ),
    buttonTheme: const ButtonThemeData(
        height: 50.0,
        buttonColor: AppColors.goldSand,
        textTheme: ButtonTextTheme.normal),
    iconTheme: const IconThemeData(color: AppColors.terracotta),
  );
}
