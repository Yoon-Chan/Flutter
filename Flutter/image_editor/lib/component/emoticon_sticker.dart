import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmoticonSticker extends StatefulWidget {
  //스티커를 그리는 위젯
  final VoidCallback onTransform;
  final String imgPath;
  final bool isSelected;

  const EmoticonSticker(
      {required this.onTransform,
      required this.imgPath,
      required this.isSelected,
      Key? key})
      : super(key: key);

  @override
  State<EmoticonSticker> createState() => _EmoticonSticker();
}

class _EmoticonSticker extends State<EmoticonSticker> {
  double scale = 1; //확대/축소 배율

  double hTransform = 0; //가로의 움직임

  double vTransform = 0; //세로의 움직임
  double actualScale = 1; // 위젯의 초기 크기 기준 확대/축소 배율

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.identity()
          ..translate(hTransform, vTransform) //상하 움직임 정의
          ..scale(scale, scale),    // 확대/ 축소 정의
        child: Container(
          decoration: widget.isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                )
              : BoxDecoration(
                  // 테두리는 투명이나 너비는 1로 설정해서 스티커가 선택 취소될 때 깜빡이는 현상 제구
                  border: Border.all(
                  width: 1.0,
                  color: Colors.transparent,
                )),
          child: GestureDetector(
            //스티커를 눌렀을 때 실행할 함수
            onTap: () {
              //스티커의 상태가 변경될 때마다 실행
              widget.onTransform();
            },
            //스티커의 확대 비율이 변경 됐을 때 실행
            onScaleUpdate: (details) {
              widget.onTransform();

              setState(() {
                scale = details.scale * actualScale;

                vTransform += details.focalPointDelta.dy; // 세로 이동 거리 계산
                hTransform += details.focalPointDelta.dx; // 가로 이동 거리 계산
              });
            },

            //스티커의 확대 비율 변경이 완료됐을 때 실행
            onScaleEnd: (details) {
              actualScale = scale; // 확대 비율 저장
            },

            child: Image.asset(widget.imgPath),
          ),
        ));
  }
}
