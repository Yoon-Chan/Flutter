import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Map<DateTime, List<Schedules>> schedules = {
    DateTime.utc(2024, 5, 21): [
      Schedules(
          id: 1,
          startTime: 11,
          endTime: 12,
          content: '플러터 공부하기',
          date: DateTime.utc(2024, 5, 21),
          color: categoryColors[0],
          createdAt: DateTime.now().toUtc()),
      Schedules(
          id: 2,
          startTime: 14,
          endTime: 16,
          content: '안드로이드 공부하기',
          date: DateTime.utc(2024, 5, 21),
          color: categoryColors[1],
          createdAt: DateTime.now().toUtc()),
      Schedules(
          id: 1,
          startTime: 11,
          endTime: 12,
          content: '플러터 공부하기',
          date: DateTime.utc(2024, 5, 21),
          color: categoryColors[0],
          createdAt: DateTime.now().toUtc()),
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ScheduleBottomSheet();
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Calendar(
              focusedDay: DateTime.now(),
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              taskCount: 0,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: ListView(
                  children: schedules.containsKey(selectedDay)
                      ? schedules[selectedDay]!
                          .map((e) => ScheduleCard(
                              startTime: e.startTime,
                              endTime: e.endTime,
                              content: e.content,
                              color: Color(int.parse('FF${e.color}', radix: 16))))
                          .toList()
                      : [],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime day) {
    return day.isAtSameMomentAs(selectedDay!);
  }
}
