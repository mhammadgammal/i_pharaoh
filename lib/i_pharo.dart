import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/di/di.dart';
import 'package:i_pharaoh/core/helpers/cache/cache_helper.dart';
import 'package:i_pharaoh/core/helpers/cache/cache_keys.dart';
import 'package:i_pharaoh/core/router/app_router.dart';
import 'package:i_pharaoh/core/router/router_helper.dart';
import 'package:i_pharaoh/core/theme/app_theme.dart';
import 'package:i_pharaoh/core/utils/localization/app_localization.dart';
import 'package:i_pharaoh/core/utils/localization/localize_constants.dart';

class IPharo extends StatelessWidget {
  const IPharo({super.key});

  @override
  Widget build(BuildContext context) {
    bool? isFirstTime = sl<CacheHelper>().getBool(CacheKeys.firstTime);
    String? uid = sl<CacheHelper>().getString(CacheKeys.uid);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPharo',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: isFirstTime == true
          ? RouterHelper.boarding
          : uid == null
              ? RouterHelper.signIn
              : RouterHelper.home,
      routes: AppRouter.generateRoute,
      locale: sl<AppLanguage>().appLocal,
      supportedLocales: LocalizeConstants.supportedLocales,
      localizationsDelegates: LocalizeConstants.delegates,
    );
  }
}
