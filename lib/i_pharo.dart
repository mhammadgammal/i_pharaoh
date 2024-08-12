import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/router/app_router.dart';
import 'package:i_pharaoh/core/router/router_helper.dart';
import 'package:i_pharaoh/core/theme/app_theme.dart';

class IPharo extends StatelessWidget {
  const IPharo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPharo',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: RouterHelper.boarding,
      routes: AppRouter.generateRoute,
    );
  }
}
