import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/router/app_navigator.dart';
import 'package:i_pharaoh/core/theme/app_colors.dart';
import 'package:i_pharaoh/core/theme/app_images.dart';
import 'package:i_pharaoh/core/theme/app_strings.dart';
import 'package:i_pharaoh/core/utils/screen_util/screen_utils.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  final PageController pageController = PageController();
  final List<(String, String)> pages = [
    (AppImages.onBoarding1, AppStrings.onBoardingText1),
    (AppImages.onBoarding2, AppStrings.onBoardingText2),
    (AppImages.onBoarding3, AppStrings.onBoardingText3),
  ];

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtils.getScreenWidth(context);
    double height = ScreenUtils.getScreenHeight(context);
    log('Screen Width: $width');
    log('Screen Height: $height');
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView.builder(
            controller: widget.pageController,
            itemCount: widget.pages.length,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                isLast = value == (widget.pages.length - 1);
                currentPage = value;
              });
            },
            itemBuilder: (context, index) => Container(
              alignment: AlignmentDirectional.bottomEnd,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        widget.pages[index].$1,
                      ),
                      fit: BoxFit.fitWidth)),
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 60.0,
                  start: width * 0.1,
                  end: width * 0.1,
                ),
                child: Text(
                  style: Theme.of(context).textTheme.bodyMedium,
                  widget.pages[index].$2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            // width: 115.0,
            height: 30.0,
            margin: const EdgeInsetsDirectional.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () async {
                if (isLast) {
                  log('last');
                  AppNavigator.navigateReplacementToLogin(context);
                } else {
                  log('trying to get next page');
                  await widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: const ElasticInCurve(),
                  );
                }
              },
              child: Text(
                isLast ? 'Get Started' : 'Next',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall?.copyWith(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
