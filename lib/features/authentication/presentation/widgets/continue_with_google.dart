import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/theme/app_colors.dart';

import '../../../../core/theme/app_images.dart';

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(
                  color: AppColors.goldSand,
                  width: 1.0,
                )),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            // Set the desired width of the image.
            height: 25,
            // Set the desired height of the image.
            child: Image.asset(
              AppImages.googleIc,
              // Set the desired height of the image.
              fit: BoxFit.contain,
            ),
          ),
          Text(
            '    Continue with Google',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
