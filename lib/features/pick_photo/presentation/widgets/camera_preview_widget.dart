import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatelessWidget {
  const CameraPreviewWidget(this.controller,
      {super.key,
      required this.initializeCamera,
      required this.onPhotoTaken,
      required this.pickPhoto});
  final Future<void> Function() initializeCamera;
  final CameraController controller;
  final Future<void> Function() onPhotoTaken;
  final Future<void> Function() pickPhoto;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FutureBuilder(
          future: initializeCamera(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              log('message: ${snapshot.connectionState}');
              // If the Future is complete, display the preview.
              return RotatedBox(
                quarterTurns: 1,
                child: AspectRatio(
                  aspectRatio: 1.99,
                  child: CameraPreview(controller),
                ),
              );
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Opacity(
            opacity: 0.5,
            child: Container(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () => pickPhoto(),
                      icon: const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () => onPhotoTaken(),
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      )),
                ],
              ),
            ))
      ],
    );
  }
}
