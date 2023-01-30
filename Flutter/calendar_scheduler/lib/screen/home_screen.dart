import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/const/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/const/schedule_card.dart';
import 'package:calendar_scheduler/const/today_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    //선택된 날짜를 관리할 함수
      DateTime
          .now()
          .year,
      DateTime
          .now()
          .month,
      DateTime
          .now()
          .day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: PRIMARY_COLOR,
          onPressed: () {
            showModalBottomSheet(
                context: context, builder: (context) => ScheduleBottomSheet(),
                isDismissible: true, //배경을 탭했을 때 BottomSheet 닫기
                isScrollControlled: true,
            );
          },
          child: Icon(Icons.add),
        ),


        body: SafeArea(
          child: Column(
            children: [
              MainCalendar(
                selectedDate: selectedDate, //선택된 날짜 전달하기

                //날짜가 선택됐을 때 실행할 함수
                onDaySelected: onDaySelected,
              ),
              SizedBox(
                height: 8,
              ),
              TodayBanner(
                selectedDate: selectedDate,
                count: 0,
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ScheduleCard(
                  startTime: 12,
                  endTime: 14,
                  content: '프로그래밍 공부',
                ),
              )
            ],
          ),
        ));
  }

  void onDaySelected(DateTime selectedDate, DateTime focusDate) {
    //날짜 선택될 때만다 실행할 함수
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
