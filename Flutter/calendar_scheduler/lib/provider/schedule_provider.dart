import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository repository;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Map<DateTime, List<ScheduleModel>> cache = {}; //일정 정보를 저장해둘 변수

  ScheduleProvider({
    required this.repository,
  }) : super() {
    getSchedules(date: selectedDate);
  }

  void getSchedules({required DateTime date}) async {
    final resp = await repository.getSchedules(date: date); //GET메서드 보내기

    //선택한 날짜의 일정들 업데이트하기
    cache.update(date, (value) => resp, ifAbsent: () => resp);

    notifyListeners(); //리셋하는 위젯들 업데이트하기
  }

  void createSchedule({
    required ScheduleModel schedule,
  }) async {
    final targetData = schedule.date;

    final savedSchedule = await repository.createSchedule(schedule: schedule);

    final uuid = Uuid();

    final tempId = uuid.v4();
    final newSchedule = schedule.copyWith(id: tempId);
    cache.update(
      targetData,
      (value) => [
        // 현존하는 캐시 리스트 끝에 새로운 일정 추가
        ...value,
        newSchedule,
      ]..sort(
          (a, b) => a.startTime.compareTo(b.startTime),
        ),
      ifAbsent: () => [newSchedule],
    );

    notifyListeners();

    try {
      //API 요청
      final savedSchedule = await repository.createSchedule(schedule: schedule);

      cache.update(
          targetData,
          (value) => value
              .map((e) => e.id == tempId ? e.copyWith(id: savedSchedule) : e)
              .toList());
    } catch (e) {
      cache.update(targetData,
          (value) => value.where((element) => element.id != tempId).toList());
    }

    notifyListeners();
  }

  void deleteSchedule({
    required DateTime date,
    required String id,
  }) async {
    final targetSchedule =
        cache[date]!.firstWhere((element) => element.id == id);

    cache.update(
      date,
      (value) => value.where((element) => element.id != id).toList(),
      ifAbsent: () => [],
    );

    notifyListeners();

    try {
      await repository.deleteSchedule(id: id);
    } catch (e) {
      cache.update(
          date,
          (value) => [...value, targetSchedule]..sort(
              (a, b) => a.startTime.compareTo(b.startTime),
            ));
    }

    notifyListeners();
  }

  void changeSelectedDate({
    required DateTime date,
  }) {
    selectedDate = date;
    notifyListeners();
  }
}
