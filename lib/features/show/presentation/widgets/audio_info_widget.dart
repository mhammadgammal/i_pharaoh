import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/theme/app_colors.dart';
import 'package:just_audio/just_audio.dart';

class AudioInfoWidget extends StatefulWidget {
  const AudioInfoWidget(this.audioUrl, {super.key});

  final String audioUrl;

  @override
  State<AudioInfoWidget> createState() => _AudioInfoWidgetState();
}

class _AudioInfoWidgetState extends State<AudioInfoWidget> {
  final player = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    log('AudioInfoWidget: Audio Url: ${widget.audioUrl}');
    player.setUrl(widget.audioUrl);
    player.positionStream.listen((p) => setState(() {
          position = p;
        }));
    player.durationStream.listen((d) => setState(() {
          duration = d ?? Duration.zero;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.goldenrodYellow,
      child: Row(
        children: [
          IconButton(
            onPressed: handlePlayPause,
            icon: player.playing
                ? const Icon(
                    Icons.pause,
                    size: 40,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.play_arrow,
                    size: 40,
                    color: Colors.white,
                  ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Slider(
                  value: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble(),
                  onChanged: handleSeek,
                  overlayColor: const WidgetStatePropertyAll(Colors.white),
                  activeColor: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text('${formatDuration(position)} : '),
                    Text(formatDuration(duration))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDuration(Duration d) {
    final min = d.inMinutes.remainder(60);
    final sec = d.inSeconds.remainder(60);
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  void handlePlayPause() {
    if (player.playing) {
      setState(() {
        player.pause();
      });
    } else {
      setState(() {
        player.play();
      });
    }
  }

  void handleSeek(double value) {
    setState(() {
      player.seek(Duration(seconds: value.toInt()));
    });
  }
}
