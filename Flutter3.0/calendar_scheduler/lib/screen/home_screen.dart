import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
              children: [
                Calendar(
                  focusedDay: DateTime.now(),
                  onDaySelected: onDaySelected,
                  selectedDayPredicate: selectedDayPredicate,
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
    if (selectedDay == null) return false;
    return day.isAtSameMomentAs(selectedDay!);
  }

}
