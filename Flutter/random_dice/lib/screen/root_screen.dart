import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;
  double threshold = 2.7;
  int number = 1;
  ShakeDetector? shakeDetector;
  
  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);

    controller!.addListener(tabListener);
    
    shakeDetector = ShakeDetector.autoStart(
        shakeSlopTimeMS: 100, //감지 주기
        shakeThresholdGravity: threshold, //감지 민감도
        onPhoneShake: onPhoneSake
    );
  }
  
  void onPhoneSake() {// 감지 후 실행할 함수
    final rand = new Random();
    
    setState(() {
      number = rand.nextInt(6)+1; //1~6 사이의 값
    });
  }

  tabListener() {
    setState(() {
    });
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener);
    shakeDetector!.stopListening(); //흔들기 감지 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children:
          renderChilren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChilren() {
    return [
      HomeScreen(number: number),
      SettingsScreen(threshold: threshold , onThresholdChange: onThresholdChange)
    ];
  }

  void onThresholdChange(double val){
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    //탭 네비게이션을 구현하는 위젯
    return BottomNavigationBar(

      //현재 화면에 렌더링되는 탭의 인덱스
      currentIndex: controller!.index,
      onTap: (int index){
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.edgesensor_high_outlined), label: "주사위"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "설정"),
      ],
    );
  }
}
