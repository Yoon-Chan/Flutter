import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;
  final bool Function(DateTime day)? selectedDayPredicate;

  const Calendar({
    super.key,
    required this.focusedDay,
    required this.onDaySelected,
    required this.selectedDayPredicate,
  });

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.grey[200]!, width: 1.0));

    final defaultStyle = TextStyle(color: Colors.grey[600]!);

    return TableCalendar(
      locale: 'ko-kr',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
      ),
      calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          defaultDecoration: defaultDecoration,
          weekendDecoration: defaultDecoration,
          selectedDecoration: defaultDecoration.copyWith(
              border: Border.all(color: primaryColor, width: 1.0)),
          defaultTextStyle: defaultStyle,
          weekendTextStyle: defaultStyle,
          selectedTextStyle: defaultStyle.copyWith(color: primaryColor),
          todayDecoration: defaultDecoration.copyWith(color: primaryColor),
          outsideDecoration: defaultDecoration.copyWith(
              border: Border.all(color: Colors.transparent))),
      onDaySelected: onDaySelected,
      selectedDayPredicate: selectedDayPredicate,
    );
  }
}
