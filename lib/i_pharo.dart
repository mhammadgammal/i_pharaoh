import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/theme/app_theme.dart';
import 'package:i_pharaoh/features/boarding/presentation/on_boarding_screen.dart';

class IPharo extends StatelessWidget {
  const IPharo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPharo',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: OnBoardingScreen(),
    );
  }
}
