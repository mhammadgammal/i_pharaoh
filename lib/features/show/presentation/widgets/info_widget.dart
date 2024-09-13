import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/utils/localization/app_localization.dart';
import 'package:i_pharaoh/features/show/presentation/widgets/selection_button.dart';
import 'package:i_pharaoh/features/show/presentation/widgets/video_section.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/localization/app_strings.dart';
import '../../../../core/utils/screen_util/screen_utils.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget(
      {super.key,
      required this.infoText,
      required this.videoUrl,
      required this.selectionButtonController,
      required this.onSelectionChanged});

  final SelectionButtonController selectionButtonController;
  final Function(String) onSelectionChanged;
  final String infoText;
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectionButton(
            selectButtonController: selectionButtonController,
            options: [
              AppLocalizations.of(context).translate(AppStrings.text),
              AppLocalizations.of(context).translate(AppStrings.video),
            ],
            buttonWidth: ScreenUtils.getScreenWidth(context) * 0.32,
            buttonHeight: ScreenUtils.getScreenHeight(context) * 0.06,
            onChange: onSelectionChanged),
        selectionButtonController.value == AppStrings.text
            ? Padding(
                padding: const EdgeInsetsDirectional.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .translate(AppStrings.readAbout),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsetsDirectional.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.goldenrodYellow, width: 1.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25.0))),
                      child: Text(
                        infoText,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            : VideoSection(videoUrl: videoUrl),
      ],
    );
  }
}
