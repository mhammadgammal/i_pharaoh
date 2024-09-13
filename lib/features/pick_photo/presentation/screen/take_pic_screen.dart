import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/router/app_navigator.dart';
import 'package:i_pharaoh/core/theme/app_colors.dart';
import 'package:i_pharaoh/core/utils/screen_util/screen_utils.dart';
import 'package:i_pharaoh/features/pick_photo/presentation/cubit/pick_photo_cubit.dart';
import 'package:i_pharaoh/features/pick_photo/presentation/widgets/camera_placeholder_widget.dart';

class TakePicScreen extends StatelessWidget {
  const TakePicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late PickPhotoCubit cubit;
    return Scaffold(
      body: BlocConsumer<PickPhotoCubit, PickPhotoState>(
        listener: (context, state) {
          if(state is ImageTakenState){
            log('TakePicScreen: ImageTakenState: ${cubit.path}');
            AppNavigator.navigateToShow(context, cubit.path);
          }
        },
        builder: (context, state) {
          cubit = PickPhotoCubit.get(context);
          var screenWidth = ScreenUtils.getScreenWidth(context);
          var screenHeight = ScreenUtils.getScreenHeight(context);

          return state is CheckCameraPermissionState ||
                  cubit.cmaeraPermissionState ==
                      CmaeraPermissionRequestState.DENIED ||
                  cubit.cmaeraPermissionState ==
                      CmaeraPermissionRequestState.PERMANENTLY_DENIED
              ? CameraPlaceholderWidget(
                  handleDenial: () => cubit.handleDenial(),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FutureBuilder(
                          future: cubit.initializeCamera(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              // If the Future is complete, display the preview.
                              return RotatedBox(
                                quarterTurns: 1,
                                child: AspectRatio(
                                  aspectRatio: 1.99,
                                  child: CameraPreview(cubit.controller),
                                ),
                              );
                            } else {
                              // Otherwise, display a loading indicator.
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                        Opacity(
                            opacity: 0.5,
                            child: Container(
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () => cubit.pickPhoto(),
                                      icon: const Icon(
                                        Icons.photo_library,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () => context
                                          .read<PickPhotoCubit>()
                                          .onPhotoTaken(),
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ))
                      ],
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: AppColors.lightGrey,
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
