import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_dice/const/colors.dart';

class SettingsScreen extends StatelessWidget {
  final double threshold; //Slider의 현잿값
  final ValueChanged<double> onThresholdChange;

  const SettingsScreen(
      {Key? key,

      //Threshold와 onThresholdChange는 SettingsScreen에서 입력
      required this.threshold,
      required this.onThresholdChange})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text("민감도",
              style: TextStyle(
                color: secondaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),)
            ],
          ),
        ),

        Slider(
          min: 0.1, //최솟값
          max: 10.0, //최댓값
          divisions: 101, //최솟값과 최댓값의 구간 개수
          value: threshold,
          onChanged: onThresholdChange,
          label: threshold.toStringAsFixed(1),  //표싯값
        )
      ],
    );
  }
}
