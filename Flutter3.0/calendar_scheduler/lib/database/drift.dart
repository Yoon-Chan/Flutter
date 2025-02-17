import 'dart:io';

//p로 사용하기 위해 적용
import 'package:calendar_scheduler/model/category.dart';
import 'package:calendar_scheduler/model/schedule_with_category.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'package:sqlite3/sqlite3.dart';

//코드 제너레이션
part 'drift.g.dart';

// dart run build_runner build  명령어를 실행하면 코드가 자동으로 생성된다.
@DriftDatabase(tables: [ScheduleTable, CategoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<int> createCategory(CategoryTableCompanion data) =>
      into(categoryTable).insert(data);

  //카테고리 정보
  Future<List<CategoryTableData>> getCategories() =>
      select(categoryTable).get();

  //id schedule 가져오기
  Future<ScheduleWithCategory> getScheduleById(int id) {
    // (select(scheduleTable)..where((tbl) => tbl.id.equals(id))).getSingle();
    final query = select(scheduleTable).join([
      innerJoin(
          categoryTable, categoryTable.id.equalsExp(scheduleTable.colorId)),
    ])
      ..where(scheduleTable.id.equals(id));

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);
      return ScheduleWithCategory(category: category, schedule: schedule);
    }).getSingle();
  }

  //update
  Future<int> updateScheduleById(int id, ScheduleTableCompanion data) =>
      (update(scheduleTable)..where((tbl) => tbl.id.equals(id))).write(data);

  Future<List<ScheduleTableData>> getSchedules() => select(scheduleTable).get();

  //반환값은 생성한 값의 id 값 -> 주로 int
  //파라미터 - 업데이트나 생성할 때 Companion 사용
  Future<int> createSchedule(ScheduleTableCompanion data) =>
      into(scheduleTable).insert(data);

  //특정 날짜의 일정들을 가져오는 방법
  Future<List<ScheduleTableData>> getSchedulesOfDay(DateTime date) {
    //아래 3줄 코드와 같은 방식이다. ..을 이용하여 select()문의 반환값을 가져올 수 있다.
    return (select(scheduleTable)
          ..where((tbl) => tbl.date.equals(date))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.startTime, mode: OrderingMode.asc),
            (tbl) =>
                OrderingTerm(expression: tbl.endTime, mode: OrderingMode.asc),
          ]))
        .get();

    // final selectQuery = select(scheduleTable);
    // selectQuery.where((tbl) => tbl.date.equals(date));
    // return selectQuery.get();
  }

  //Stream 형식으로 변화 감지할 때마다 변경하는 기능 구현
  Stream<List<ScheduleWithCategory>> getStreamSchedulesOfDay(DateTime date) {
    final query = select(scheduleTable).join([
      innerJoin(
          categoryTable, categoryTable.id.equalsExp(scheduleTable.colorId)),
    ])
      ..where(scheduleTable.date.equals(date));

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);
      return ScheduleWithCategory(category: category, schedule: schedule);
    }).watch();

    //아래 3줄 코드와 같은 방식이다. ..을 이용하여 select()문의 반환값을 가져올 수 있다.
    // return (select(scheduleTable)..where((tbl) => tbl.date.equals(date)))
    //     .watch();

    // final selectQuery = select(scheduleTable);
    // selectQuery.where((tbl) => tbl.date.equals(date));
    // return selectQuery.get();
  }

  //삭제
  Future<int> removeSchedule(int id) =>
      (delete(scheduleTable)..where((tbl) => tbl.id.equals(id))).go();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    //앱을 설치를 하면 앱 별로 생성되는 폴더의 위치를 가져오는 함수 -> getApplicationDocumentsDirectory()
    final dbFolder = await getApplicationDocumentsDirectory();
    //dart:io에서 가져와야 한다.
    //경로들을 운영체제에 맞게 합쳐준다.
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    //안드로이드인 경우
    if (Platform.isAndroid) {
      //예전 안드로이드 버그를 해결해주는 코드
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    //임시 폴더를 가져오는 함수.
    final cachebase = await getTemporaryDirectory();

    //배정 받는 임시 폴더를 저장한다.
    sqlite3.tempDirectory = cachebase.path;

    return NativeDatabase.createInBackground(file);
  });
}
