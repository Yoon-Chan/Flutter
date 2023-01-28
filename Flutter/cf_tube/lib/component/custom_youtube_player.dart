import 'package:cf_tube/model/video_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutubePlayer extends StatefulWidget {
  //상위 위젯에서 입력받을 동영상 정보
  final VideoModel videoModel;

  const CustomYoutubePlayer({required this.videoModel, Key? key})
      : super(key: key);

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayer();
}


class _CustomYoutubePlayer extends State<CustomYoutubePlayer> {

  //YoutubePlayer 위젯을 조정하기 위한 YoutubePlayerController 위젯 사용
  YoutubePlayerController? controller;

  @override
  void initState() {
    super.initState();

    //컨트롤러 선언
    controller = YoutubePlayerController(
        initialVideoId: widget.videoModel.id, // 처음 실행할 동영상의 ID
        flags: YoutubePlayerFlags(
          autoPlay: false, //자동 실행 사용하지 않기
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        YoutubePlayer(
          controller: controller!,
          showVideoProgressIndicator: true,
        ),

        const SizedBox(height: 16.0,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.videoModel.title, //동영상 제목
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 16.0,),
      ],

    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    controller!.dispose();  // State 폐기 시 컨트롤러 또한 폐기
  }
}