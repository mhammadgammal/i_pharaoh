import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'pick_photo_state.dart';

class PickPhotoCubit extends Cubit<PickPhotoState> {
  PickPhotoCubit() : super(PickPhotoInitial());
  late CameraController _controller;
  CameraController get controller {
    try {
      return _controller;
    } catch (e) {
      log(e.toString());
      openCamera();
      return _controller;
    }
  }

  String _path = '';

  set path(String imagePath) {
    _path = imagePath;
    emit(ImageSetState());
  }

  String get path => _path;
  CmaeraPermissionRequestState cmaeraPermissionState =
      CmaeraPermissionRequestState.DENIED;
  static PickPhotoCubit get(context) => BlocProvider.of(context);

  Future requestCameraPermission() async {
    var cameraPermssion = Permission.camera;

    if (await cameraPermssion.request().isDenied) {
      cmaeraPermissionState = CmaeraPermissionRequestState.DENIED;
    } else if (await cameraPermssion.request().isGranted) {
      cmaeraPermissionState = CmaeraPermissionRequestState.GRANTED;
      openCamera();
    } else if (await cameraPermssion.request().isPermanentlyDenied) {
      cmaeraPermissionState = CmaeraPermissionRequestState.PERMANENTLY_DENIED;
    }
    emit(CmaeraPermissionState(
      permissionState: cmaeraPermissionState,
    ));
    log('isCameraPermissionGranted: $cmaeraPermissionState');
  }

  Future<void> initializeCamera() async {
    log('In Initialize Camera');
    _controller = CameraController(
      enableAudio: false,
      const CameraDescription(
        name: '1',
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 1,
      ),
      ResolutionPreset.high,
    );
    return _controller.initialize();
  }

  Future<void> openCamera() async {
    await initializeCamera();
    emit(CameraInitializedState());
  }

  Future<void> onPhotoTaken() async {
    {
      // Take the Picture in a try / catch block. If anything goes wrong,
      // catch the error.
      try {
        // Ensure that the camera is initialized.
        await initializeCamera();

        // Attempt to take a picture and get the file `image`
        // where it was saved.
        final image = await controller.takePicture();

        // If the picture was taken, display it on a new screen.
        path = image.path;
        log(image.path);
        emit(ImageTakenState());
      } catch (e) {
        // If an error occurs, log the error to the console.
        debugPrint(e.toString());
      }
    }
  }

  Future<void> pickPhoto() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      path = image.path;
      emit(ImageTakenState());
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<void> dispose() async {
    await _controller.dispose();
  }

  Future<void> handleDenial() async {
    cmaeraPermissionState == CmaeraPermissionRequestState.DENIED
        ? await requestCameraPermission()
        : cmaeraPermissionState ==
                CmaeraPermissionRequestState.PERMANENTLY_DENIED
            ? openAppSettings().then((isGranted) {
                if (isGranted) {
                  openCamera();
                }
              })
            : null;
  }
}

enum CmaeraPermissionRequestState { GRANTED, DENIED, PERMANENTLY_DENIED }
