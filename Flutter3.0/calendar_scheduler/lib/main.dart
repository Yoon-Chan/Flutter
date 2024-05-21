import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  //플러터 프레임워크가 실행할 준비가 되어 있는지 확인을 하는 절차
  //원래 runApp을 실행하면 자동으로 실행된다.

  //하지만 runApp 말고 다른 함수를 먼저 실행하고 싶을 때 직접 사용하는 경우가 있다.
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(
      MaterialApp(
    home: HomeScreen(),
  ));
}
