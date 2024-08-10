import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/theme/app_images.dart';
import 'package:i_pharaoh/core/utils/screen_util/screen_utils.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  final PageController pageController = PageController();
  final List<(String, String)> pages = [
    (AppImages.onBoarding1, 'Coming to visit one of the Egyptian Landmarks ?'),
    (AppImages.onBoarding2, 'Need information about specific artifact ?'),
    (
      AppImages.onBoarding3,
      'Don’t worry all you need is to scan it with your phone'
    ),
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
    print('Screen Width: $width');
    print('Screen Height: $height');
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
            itemBuilder: (context, index) => Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image.asset(
                  widget.pages[index].$1,
                  width: ScreenUtils.getScreenWidth(context),
                  height: ScreenUtils.getScreenHeight(context),
                ),
                Padding(
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
              ],
            ),
          ),
          Container(
            // width: 115.0,
            height: 30.0,
            margin: const EdgeInsetsDirectional.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () async {
                if (isLast) {
                  print('last');
                } else {
                  print('trying to get next page');
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
                    .bodySmall
                    ?.copyWith(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
