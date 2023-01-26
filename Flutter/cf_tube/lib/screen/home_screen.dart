


import 'package:cf_tube/component/custom_youtube_player.dart';
import 'package:cf_tube/model/video_model.dart';
import 'package:cf_tube/repository/youtube_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '코팩튜브'
        ),
        backgroundColor: Colors.black,
      ),

      backgroundColor: Colors.black,
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideo(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text(
                snapshot.hasError.toString(),
              ),
            );
          }

          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // List<VideoModel> 을 CustomYoutubePlayer로 매핑
          return ListView(
            //아래로 당겨서 스크롤할 때 튕기는 애니메이션 추가
            physics: BouncingScrollPhysics(),
            children: snapshot.data!
            .map((e) =>  CustomYoutubePlayer(
                videoModel: e )).toList(),
          );
        },
      ),
    );

  }

}