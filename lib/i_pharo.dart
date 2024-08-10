import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/theme/app_theme.dart';

class IPharo extends StatelessWidget {
  const IPharo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPharo',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: const Placeholder(),
    );
  }
}
