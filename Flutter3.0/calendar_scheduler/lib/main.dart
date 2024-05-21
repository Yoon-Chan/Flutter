import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  //플러터 프레임워크가 실행할 준비가 되어 있는지 확인을 하는 절차
  //원래 runApp을 실행하면 자동으로 실행된다.

  //하지만 runApp 말고 다른 함수를 먼저 실행하고 싶을 때 직접 사용하는 경우가 있다.
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  //database 초기화
  final database = AppDatabase();

  //의존성 주입
  GetIt.I.registerSingleton<AppDatabase>(database);

  // //데이터 넣기
  // await database.createSchedule(
  //   ScheduleTableCompanion(
  //     startTime: const Value(12),
  //     endTime: const Value(12),
  //     content: const Value('Flutter'),
  //     date: Value(DateTime.utc(2024, 3, 21)),
  //     color: Value(categoryColors.first),
  //   )
  // );
  //
  // //데이터 가져오기
  // final resp = await database.getSchedules();
  // print(resp);


  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'NotoSans'),
    home: HomeScreen(),
  ));
}
