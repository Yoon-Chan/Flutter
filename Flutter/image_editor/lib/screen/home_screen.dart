import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/component/emoticon_sticker.dart';
import 'package:image_editor/component/footer.dart';
import 'package:image_editor/component/main_app_bar.dart';
import 'package:image_editor/component/sticker_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  XFile? image; //선택한 이미지를 저장할 변수
  Set<StickerModel> stickers = {}; //화면에 추가된 스티커를 저장할 변수
  String? selectedId; // 현재 선택된 스티커의 ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // 자식 위젯 최대 크기로 펼치기
        children: [
          renderBody(),

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

          //Footer 위치하기
          if (image != null)
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Footer(
                  onEmotionTap: onEmotionTap,
                ))
        ],
      ),
    );
  }

  void onPickImage() async {
    //갤러리에서 이미지 선택
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      this.image = image;
    });
  }

  void onDeleteItem() async {
    setState(() {
      stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();
    });
  }

  void onSaveImage() {}

  Widget renderBody() {
    if (image != null) {
      // Stack 크기의 최대 크기만큼 차지하기
      return Positioned.fill(
          //위젯 확대 및 좌우 이동을 가능하게 하는 위젯
          child: InteractiveViewer(
              child: Stack(
        fit: StackFit.expand, //크기 최대로 늘려주기
        children: [
          Image.file(
            File(image!.path),
            fit: BoxFit.cover,
          ),
          ...stickers.map((sticker) => Center(
                child: EmoticonSticker(
                  key: ObjectKey(sticker.id),
                  onTransform: (){
                    onTransform(sticker.id);
                  },
                  imgPath: sticker.imgPath,
                  isSelected: selectedId == sticker.id,
                ),
              ))
        ],
      )));
    } else {
      //이미지 선택이 안 된 경우 이미지 선택 버튼 표시
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.grey,
          ),
          onPressed: onPickImage,
          child: Text("이미지 선택하기"),
        ),
      );
    }
  }

  void onEmotionTap(int index) {
    setState(() {
      stickers = {
        ...stickers,
        StickerModel(
          id: Uuid().v4(),//스티커의 고유 ID
          imgPath: 'asset/img/emoticon_$index.png'
        )

      };
    });
  }

  void onTransform(String id) {
    //스티커가 변형될 때마다 변형 중인
    //스티커를 현재 선택한 스티커로 지정
    setState(() {
      selectedId = id;
    });
  }
}
