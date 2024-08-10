import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import '../theme/app_text_style.dart';

class ErrorDialogue extends StatelessWidget {
  const ErrorDialogue({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(
        Icons.warning_amber_outlined,
        size: 35.0,
      ),
      content: Text(
        errorMessage,
        style: AppTextStyle.font15BlackNormal,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Ok',
              style: TextStyle(color: AppColors.papyrusCream, fontSize: 15),
            )),
      ],
    );
  }
}
