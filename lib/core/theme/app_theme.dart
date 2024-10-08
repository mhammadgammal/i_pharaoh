import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.goldSand),
        foregroundColor: WidgetStatePropertyAll(AppColors.papyrusCream),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.terracotta),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 20,
        color: AppColors.papyrusCream,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 15,
        color: AppColors.papyrusCream,
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 10,
        color: AppColors.papyrusCream,
      ),
    ),
  );
}
