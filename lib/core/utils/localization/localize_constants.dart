import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i_pharaoh/core/di/di.dart';
import 'package:i_pharaoh/core/helpers/cache/cache_helper.dart';
import 'package:i_pharaoh/core/helpers/cache/cache_keys.dart';
import 'dart:ui';

import 'app_localization.dart';

abstract class LocalizeConstants {
  static const List<String> _locale = ['en', 'ar'];

  static final String _defaultLanguage =
      sl<CacheHelper>().getString(CacheKeys.defaultLanguage) ?? _getDeviceLanguage();

  static const _supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static const List<LocalizationsDelegate> _delegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  //#region Localization Getters
  static List<String> get locale => _locale;

  static String get defaultLanguage => _defaultLanguage;

  static List<Locale> get supportedLocales => _supportedLocales;

  static List<LocalizationsDelegate> get delegates => _delegates;

  //#endregion

 
 static String _getDeviceLanguage() {
  Locale deviceLocale = window.locale;
  log('Locale: ${deviceLocale.languageCode}');
  return deviceLocale.languageCode; // Returns the language code (e.g., 'en', 'fr')
}

}
