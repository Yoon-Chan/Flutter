import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate; // 선택된 날짜 상위 위젯에서 입력받기

  const ScheduleBottomSheet({required this.selectedDate, Key? key})
      : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheet();
}

class _ScheduleBottomSheet extends State<ScheduleBottomSheet> {
  // 폼 key 생성
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime; //시작 시간 저장 변수
  int? endTime; // 종료 시간 저장 변수
  String? content; // 일정 내용 저장 변수

  @override
  Widget build(BuildContext context) {
    // 키보드 높이 가져오기
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form(
        key: formKey,
        child: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding:
                EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
            child: Column(

              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: '시작 시간',
                        isTime: true,
                        onSaved: (String? val) {
                          // 저장이 실행되면 startTime 변수에 텍스트 필드값 저장
                          startTime = int.parse(val!!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                        child: CustomTextField(
                      //종료 시간 입력 필드
                      label: '종료 시간',
                      isTime: true,
                      onSaved: (String? val) {
                        endTime = int.parse(val!!);
                      },
                      validator: timeValidator,
                    )),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  child: CustomTextField(
                    label: '내용',
                    isTime: false,
                    onSaved: (String? val) {
                      content = val;
                    },
                    validator: contentValidator,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('저장'),
                    onPressed: () => onSavePressed(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }

  void onSavePressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      //폼 검증하기
      formKey.currentState!.save(); // 폼 저장하기


      final schedule = ScheduleModel(
          id: Uuid().v4(),
          content: content!,
          date: widget.selectedDate,
          startTime: startTime!,
          endTime: endTime!
      );


      await FirebaseFirestore.instance
      .collection(
        'schedule'
      )
      .doc(schedule.id)
      .set(schedule.toJson());
      // await GetIt.I<LocalDatabase>().createSchedule(
      //   SchedulesCompanion(
      //    startTiem: Value(startTime!),
      //    endTime: Value(endTime!),
      //     content: Value(content!),
      //     date: Value(widget.selectedDate),
      //   )
      //
      // );

      // context.read<ScheduleProvider>().createSchedule(
      //     schedule: ScheduleModel(
      //         id: 'new_model',
      //         content: content!,
      //         date: widget.selectedDate,
      //         startTime: startTime!,
      //         endTime: endTime!
      //     ),
      // );

      //일정 생성 후 화면 뒤로 가기
      Navigator.of(context).pop();
      // print(startTime);
      // print(endTime);
      // print(content);
    }
  }

  String? timeValidator(String? val) {
    if (val == null) {
      return '값을 입력해주세요';
    }

    int? number;

    try {
      number = int.parse(val);
    } catch (e) {
      return '숫자를 입력해주세요';
    }

    if (number < 0 || number > 24) {
      return '0시부터 24시 사이를 입력해주세요';
    }

    return null;
  }

  String? contentValidator(String? val) {
    if (val == null || val.length == 0) {
      return '값을 입력해주세요';
    }

    return null;
  }
}
