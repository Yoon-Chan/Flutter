

import 'dart:async';

import 'package:anmation_example/main.dart';
import 'package:anmation_example/saturnLoading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _IntroPage();

}

class _IntroPage extends State<IntroPage>{

  @override
  void initState() {

    super.initState();
    loadData();
  }


  Future<Timer> loadData() async {
  return Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AnimationApp(),));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text('애니메이션 앱'),
              SizedBox(
                height: 20,
              ),
              SaturnLoading()
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

}