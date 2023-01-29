import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreen();
}



class _HomeScreen extends State<HomeScreen>{


  DateTime selectedDate = DateTime.utc(   //선택된 날짜를 관리할 함수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              MainCalendar(
                selectedDate: selectedDate, //선택된 날짜 전달하기

                //날짜가 선택됐을 때 실행할 함수
                onDaySelected: onDaySelected,

              ),

            ],
          ),
        ));
  }


  void onDaySelected(DateTime selectedDate, DateTime focusDate){

    //날짜 선택될 때만다 실행할 함수
    setState(() {
      this.selectedDate = selectedDate;
    });


  }
}