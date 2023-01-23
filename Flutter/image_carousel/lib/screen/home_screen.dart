import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 3), (timer) {

      int? nextPage = pageController.page?.toInt();

      //페이지 값이 없을 때 예외 처리
      if(nextPage == null){
        return;
      }

      //첫 페이지와 마지막 페이지 분기 ㅓ리
      if(nextPage == 4){
        nextPage = 0;
      }else{
        nextPage++;
      }
      pageController.animateToPage(nextPage, duration: Duration(milliseconds: 500), curve: Curves.ease);


    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        //페이지 컨트롤러 등록
        controller: pageController,
        children: [1, 2, 3, 4, 5]
            .map(
              (number) => Image.asset(
                "assets/img/image_$number.jpeg",
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
