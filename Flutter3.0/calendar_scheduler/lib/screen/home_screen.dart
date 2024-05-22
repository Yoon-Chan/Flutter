import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
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

  // Map<DateTime, List<ScheduleTable>> schedules = {
  //   DateTime.utc(2024, 5, 21): [
  //     ScheduleTable(
  //         id: 1,
  //         startTime: 11,
  //         endTime: 12,
  //         content: '플러터 공부하기',
  //         date: DateTime.utc(2024, 5, 21),
  //         color: categoryColors[0],
  //         createdAt: DateTime.now().toUtc()),
  //     ScheduleTable(
  //         id: 2,
  //         startTime: 14,
  //         endTime: 16,
  //         content: '안드로이드 공부하기',
  //         date: DateTime.utc(2024, 5, 21),
  //         color: categoryColors[1],
  //         createdAt: DateTime.now().toUtc()),
  //     ScheduleTable(
  //         id: 1,
  //         startTime: 11,
  //         endTime: 12,
  //         content: '플러터 공부하기',
  //         date: DateTime.utc(2024, 5, 21),
  //         color: categoryColors[0],
  //         createdAt: DateTime.now().toUtc()),
  //   ]
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: ()  {
          showModalBottomSheet<ScheduleTable>(
              context: context,
              builder: (context) {
                return ScheduleBottomSheet(selectedDay: selectedDay);
              });
          // setState(() {
          //   schedules =
          //   { ...schedules,
          //     resp.date: [
          //       if(schedules.containsKey(resp.date)) ...schedules[resp.date]!,
          //       resp
          //     ]
          //   };
          // });
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
                child: StreamBuilder<List<ScheduleTableData>>(
                    stream: GetIt.I<AppDatabase>().getStreamSchedulesOfDay(selectedDay),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }

                      if (snapshot.data == null ) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final selectedSchedules = snapshot.data!;


                      return ListView.separated(
                        // itemCount: schedules.containsKey(selectedDay)
                        //     ? schedules[selectedDay]!.length
                        //     : 0,
                        itemCount: selectedSchedules.length,
                        itemBuilder: (context, index) {
                          // final selectedSchedules = schedules[selectedDay]!;
                          final schedule = selectedSchedules[index];
                          return Dismissible(
                            key: ObjectKey(schedule.id),
                            direction: DismissDirection.endToStart,
                            // confirmDismiss: (direction) async {
                            //     await GetIt.I<AppDatabase>().removeSchedule(schedule.id);
                            //     setState(() {});
                            //     return true;
                            // },
                            onDismissed: (direction) {
                              GetIt.I<AppDatabase>().removeSchedule(schedule.id);
                            },
                            child: ScheduleCard(
                                startTime: schedule.startTime,
                                endTime: schedule.endTime,
                                content: schedule.content,
                                color: Color(
                                  int.parse('FF${schedule.color}', radix: 16),
                                )),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16.0,
                          );
                        },
                      );
                    }),
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
