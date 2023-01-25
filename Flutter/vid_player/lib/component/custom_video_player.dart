import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_icon_button.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  //선택한 동영상을 저장할 변수
  final XFile video;
  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer(
      {required this.video, required this.onNewVideoPressed, Key? key})
      : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  //동영상을 조작하는 컨트롤러
  VideoPlayerController? videoPlayerController;
  bool showControls = false; //동영상 조작하는 아이콘을 보일지 여부

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    //t새로 선택한 동영상이 같은 동영상인지 확인
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  @override
  void initState() {
    super.initState();

    //컨트롤러 초기화
    initializeController();
  }

  initializeController() async {
    final videoController = VideoPlayerController.file(File(widget.video.path));

    await videoController.initialize();

    videoController.addListener(videoControllerListener);

    setState(() {
      videoPlayerController = videoController;
    });
  }

  void videoControllerListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
          aspectRatio: videoPlayerController!.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(
                videoPlayerController!,
              ),
              if (showControls)
                Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      renderTimeTextFromDuration(
                        //동영상 현재 위치
                          videoPlayerController!.value.position
                      ),

                      Expanded(
                        child: Slider(
                          onChanged: (double val) {
                            videoPlayerController!
                                .seekTo(Duration(seconds: val.toInt()));
                          },
                          value: videoPlayerController!.value.position.inSeconds
                              .toDouble(),
                          min: 0,
                          max: videoPlayerController!.value.duration.inSeconds
                              .toDouble(),
                        ),
                      ),
                      renderTimeTextFromDuration(
                        //동영상 총 길이
                          videoPlayerController!.value.duration
                      )
                    ],
                  ),
                ),
              ),
              if (showControls)
                Align(
                  alignment: Alignment.topRight,
                  child: CustomIconButton(
                    onPressed: widget.onNewVideoPressed,
                    iconData: Icons.photo_camera_back,
                  ),
                ),
              if (showControls)
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomIconButton(
                          onPressed: onReversePressed,
                          iconData: Icons.rotate_left),
                      CustomIconButton(
                          onPressed: onPlayPressed,
                          iconData: videoPlayerController!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                      CustomIconButton(
                          onPressed: onForwardPressed,
                          iconData: Icons.rotate_right),
                    ],
                  ),
                )
            ],
          )),
    );
  }

  Widget renderTimeTextFromDuration(Duration duration) {
    return Text(
        '${duration.inMinutes.toString().padLeft(2, "0")}:${(duration
            .inSeconds % 60).toString().padLeft(2, "0")}',
        style: TextStyle(
        color: Colors.white
    ),);
  }

  void onReversePressed() {
    final currentPosition = videoPlayerController!.value.position;

    Duration position = Duration(); //0초로 실행 위치 초기화

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);
  }

  void onPlayPressed() {
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
    } else {
      videoPlayerController!.play();
    }
  }

  void onForwardPressed() {
    //동영상 길이
    final maxPosition = videoPlayerController!.value.duration;
    final currentPosition = videoPlayerController!.value.position;

    Duration position = maxPosition; //동영상 길이로 실행 위치 초기화

    //동영상 길이에서 3초를 뺀 값보다 현재 위치가 짧을 때만 3초 더하기
    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);
  }

  @override
  void dispose() {
    videoPlayerController?.removeListener(videoControllerListener);
    super.dispose();
  }
}
