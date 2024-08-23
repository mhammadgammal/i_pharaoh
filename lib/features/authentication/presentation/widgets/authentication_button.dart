import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/theme/app_colors.dart';

import '../../../../core/widgets/shimmer_loading.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton(
      {super.key,
      required this.isLoading,
      required this.title,
      required this.onPressed});

  final bool isLoading;
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ShimmerLoading(
            baseColor: AppColors.goldSand,
            height: 48.0,
          )
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.papyrusCream,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
  }
}
