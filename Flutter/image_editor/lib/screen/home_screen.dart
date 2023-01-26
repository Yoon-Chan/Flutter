import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/component/main_app_bar.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen(
      {
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,// 자식 위젯 최대 크기로 펼치기
        children: [
          //MainAppBar를 좌, 우 , 위 끝에 정렬
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MainAppBar(
                onPickImage: onPickImage,
                onDeleteItem: onDeleteItem,
                onSaveImage: onSaveImage,
              )),
        ],

      ),
    );
  }


  void onPickImage(){}
  void onDeleteItem() {}
  void onSaveImage() {}


}
