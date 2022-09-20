import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/base_page.dart';
import '../../../utils/base_state.dart';
import '../../../utils/base_utils.dart';

/// Stateful widget to fetch and then display video content.
class VideoPage extends BaseStatefulWidget {
  final File file;
  const VideoPage({Key? key, required this.file}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends BaseState<VideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Page"),
        actions: [
          _buildDownloadButton(context),
        ],
        elevation: 0,
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  IconButton _buildDownloadButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        showCustomAlertDialog(
          context,
          title: "Download",
          message: "Are you sure you want to download?",
          onPositiveTap: () async {
            Navigator.pop(context);
            showProgressDialog();
            final response = await downloadIntoInternal(widget.file);
            dismissProgressDialog();
            if (response != null) {
              Fluttertoast.showToast(msg: response);
            } else {
              Fluttertoast.showToast(msg: "File Downloaded");
            }
          },
          onNegativeTap: () {
            Navigator.pop(context);
          },
        );
      },
      icon: const FaIcon(Icons.download),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
