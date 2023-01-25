import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreen();


}

class _HomeScreen extends State<HomeScreen> {

  XFile? video; //동영상 저장할 변수


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderEmpty() {
    //동영상 선택 전 보여줄 위젯
    return Container(

      //배경색 그라데이션 설정
      decoration: getBoxDecoration(),

      //넓이 최대로 늘리기
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed,
          ), // 로고 이미지
          SizedBox(height: 30.0,),
          _AppName() //앱 이름
        ],

      ),

    );
  }

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if(video != null){
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration(){
    return BoxDecoration(
      //그라데이션으로 색상 적용하기
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      )
    );
  }

  Widget renderVideo() {
    //동영상 선택 후 보여줄 위젯
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }

}

class _Logo extends StatelessWidget {
  final GestureTapCallback onTap;

  const _Logo({ required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset("asset/img/logo.png"),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text("VIDEO",
      style: textStyle,),

    Text("PLAYER",style: textStyle.copyWith(
    fontWeight: FontWeight.w700
    ),),
    ]
    ,
    );
  }


}