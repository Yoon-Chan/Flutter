


import 'package:drift/drift.dart';

class Schedules extends Table{

  IntColumn get id => integer().autoIncrement()();    // PRIMARY Key, 정수 열
  TextColumn get content => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get startTime => integer()();
  IntColumn get endTime => integer()();

}