import 'package:flutter/material.dart';

abstract class ScreenUtils {
  static double getScreenWidth(context) => MediaQuery.of(context).size.width;

  static double getScreenHeight(context) => MediaQuery.of(context).size.height;
}
