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
          child: TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime(1800),
            lastDay: DateTime(3000),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
              });
            },
            selectedDayPredicate: (day) {
              if(selectedDay == null) return false;
              return day.isAtSameMomentAs(selectedDay!);
            },
          ),
        ),
      ),
    );
  }
}
