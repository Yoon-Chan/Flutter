import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/color.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SafeArea(
                  bottom: true,
                  child: Container(
                    color: Colors.white,
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 16.0, right: 8.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Expanded(
                                  child: CustomTextField(
                                label: '시작 시간',
                              )),
                              SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                  child: CustomTextField(
                                label: '종료 시간',
                              ))
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          const Expanded(
                            child: CustomTextField(
                              label: '내용',
                              expand: true,
                            ),
                          ),
                          Row(
                            children: categoryColors
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 32.0,
                                      height: 32.0,
                                      decoration: BoxDecoration(
                                        color: Color(int.parse('FF$e', radix: 16)),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                );
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
                  children: [
                    ScheduleCard(
                      startTime: DateTime(2024, 05, 21, 11),
                      endTime: DateTime(2024, 05, 21, 12),
                      content: '플러터 공부하기',
                      color: Colors.blue,
                    )
                  ],
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
