import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSection extends StatefulWidget {
  const VideoSection({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  late final VideoPlayerController _controller;
  late final ChewieController chewieController;

  @override
  void initState() {
    log('VideoSection: ${widget.videoUrl}');
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          log('Video player initialized');
        });
      }).catchError((onError) {
        log('Error initializing video player: $onError');
      });
    chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Chewie(controller: chewieController),
            )
          : Container(),
    );
  }
}
