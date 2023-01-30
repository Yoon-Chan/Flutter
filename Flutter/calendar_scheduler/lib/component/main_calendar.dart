import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {

  final OnDaySelected onDaySelected; // 날짜 선택시 실행할 함수
  final DateTime selectedDate; //선택된 날짜

  MainCalendar({
    required this.onDaySelected,
    required this.selectedDate,
  });


  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_kr',


      onDaySelected: onDaySelected,

      // 선택 날짜 시 실행할 함수
      selectedDayPredicate: (day) =>
        day.year == selectedDate.year &&
        day.month == selectedDate.month &&
        day.day == selectedDate.day,

      firstDay: DateTime(1800, 1, 1),
      lastDay: DateTime(3000, 1, 1),
      focusedDay: DateTime.now(),
      //위에는 필수 요소들

      daysOfWeekHeight: 30,

      headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false, // 제목 중앙에 위치하기
          titleTextStyle: TextStyle( //제목 글꼴
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          )
      ),

      calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          cellMargin: EdgeInsets.all(5),
          defaultDecoration: BoxDecoration( //기본 날짜 스타일
            borderRadius: BorderRadius.circular(6.0),
            color: LIGHT_GREY_COLOR,

          ),

          weekendDecoration: BoxDecoration( //주말 날짜 스타일
            borderRadius: BorderRadius.circular(6.0),
            color: LIGHT_GREY_COLOR,
          ),

          selectedDecoration: BoxDecoration( //선택된 날짜 스타일
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: PRIMARY_COLOR,
                width: 1.0,
              )
          ),

          defaultTextStyle: TextStyle( //기본 글꼴
            fontWeight: FontWeight.w600,
            color: DARK_GREY_COLOR,
            fontSize: 16.0
          ),

          weekendTextStyle: TextStyle( //주말 글꼴
            fontWeight: FontWeight.w600,
            color: DARK_GREY_COLOR,
          ),

          selectedTextStyle: TextStyle( //선택된 날짜 글꼴
            fontWeight: FontWeight.w600,
            color: PRIMARY_COLOR,
          )


      ),


    );
  }
}