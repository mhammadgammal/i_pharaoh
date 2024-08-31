import 'package:flutter/material.dart';

class CameraPlaceholderWidget extends StatelessWidget {
  const CameraPlaceholderWidget(
      {super.key, this.handleDenial});

  final Future<void> Function()? handleDenial;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => handleDenial!(),
            icon: const Icon(
              size: 50.0,
              Icons.camera_alt,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
