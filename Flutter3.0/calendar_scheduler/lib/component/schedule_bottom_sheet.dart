import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';

//겹치는 이름이 있는 경우 hide를 이용해 제거할 수 있다.
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final int? id;
  final DateTime selectedDay;

  const ScheduleBottomSheet({required this.selectedDay, this.id, super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  int? startTime;
  int? endTime;
  String? content;

  String selectedColor = categoryColors.first;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    iniColor();
  }

  iniColor() async {
    if (widget.id != null) {
      final resp = await GetIt.I<AppDatabase>().getScheduleById(widget.id!);
      selectedColor = resp.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.id == null
            ? null
            : GetIt.I<AppDatabase>().getScheduleById(widget.id!),
        builder: (context, snapshot) {
          if (widget.id != null &&
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data;

          return Container(
            color: Colors.white,
            height: 400,
            child: SafeArea(
              bottom: true,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      _Time(
                        onEndSaved: onEndTimeSaved,
                        onEndValidate: onEndTimeValidate,
                        onStartSave: onStartTimeSaved,
                        onStartValidate: onStartTimeValidate,
                        startTimeInitValue: data?.startTime.toString(),
                        endTimeInitValue: data?.endTime.toString(),
                      ),
                      const SizedBox(height: 8.0),
                      _Content(
                        onSaved: onContentSaved,
                        onValidate: onContentValidate,
                        contentInitValue: data?.content.toString(),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      _Category(
                        selectColor: selectedColor,
                        onTap: (String color) {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      _SaveButton(
                        onPressed: onSavePressed,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  onStartTimeSaved(String? val) {
    if (val == null) return;
    startTime = int.parse(val);
  }

  String? onStartTimeValidate(String? val) {
    if (val == null) return '값을 입력해 주세요!!';

    if (int.tryParse(val) == null) {
      return '숫자를 입력해 주세요!!';
    }
    final time = int.parse(val);

    if (time < 0 || time > 24) return '시간 범위가 맞지 않습니다!!';
    return null;
  }

  onEndTimeSaved(String? val) {
    if (val == null) return;
    endTime = int.parse(val);
  }

  String? onEndTimeValidate(String? val) {
    if (val == null) return '값을 입력해 주세요!!';

    if (int.tryParse(val) == null) {
      return '숫자를 입력해 주세요!!';
    }
    final time = int.parse(val);
    if (time < 0 || time > 24) return '시간 범위가 맞지 않습니다!!';
    return null;
  }

  onContentSaved(String? val) {
    if (val == null) return;
    content = val;
  }

  String? onContentValidate(String? val) {
    if (val == null) return '내용을 입력해 주세요!!';
    if (val.length < 5) return '5자 이상을 입력해 주세요';
    return null;
  }

  onSavePressed() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();

      //DI 가져오기
      final database = GetIt.I<AppDatabase>();

      if (widget.id == null) {
        await database.createSchedule(ScheduleTableCompanion(
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          color: Value(selectedColor),
          date: Value(widget.selectedDay),
        ));
      } else {
        await database.updateScheduleById(
          widget.id!,
          ScheduleTableCompanion(
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            color: Value(selectedColor),
            date: Value(widget.selectedDay),
          ),
        );
      }

      Navigator.of(context).pop();

      // final schedule = ScheduleTable(
      //   id: 999,
      //   startTime: startTime!,
      //   endTime: endTime!,
      //   content: content!,
      //   color: selectedColor,
      //   date: widget.selectedDay,
      //   createdAt: DateTime.now()
      // );
      //
      // Navigator.of(context).pop(
      //   schedule
      // );
    }
  }
}

typedef OnColorSelected = void Function(String color);

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSave;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndValidate;
  final String? startTimeInitValue;
  final String? endTimeInitValue;

  const _Time({
    super.key,
    required this.onStartSave,
    required this.onStartValidate,
    required this.onEndSaved,
    required this.onEndValidate,
    required this.startTimeInitValue,
    required this.endTimeInitValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          label: '시작 시간',
          onSaved: onStartSave,
          validator: onStartValidate,
          initialValue: startTimeInitValue,
        )),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
            child: CustomTextField(
          label: '종료 시간',
          onSaved: onEndSaved,
          validator: onEndValidate,
          initialValue: endTimeInitValue,
        ))
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;
  final String? contentInitValue;

  const _Content({
    super.key,
    required this.onSaved,
    required this.onValidate,
    required this.contentInitValue,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        validator: onValidate,
        onSaved: onSaved,
        initialValue: contentInitValue,
      ),
    );
  }
}

class _Category extends StatelessWidget {
  final String selectColor;
  final OnColorSelected onTap;

  const _Category({super.key, required this.selectColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categoryColors
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  onTap(e);
                },
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                      color: Color(int.parse('FF$e', radix: 16)),
                      shape: BoxShape.circle,
                      border: e == selectColor
                          ? Border.all(color: Colors.black, width: 4.0)
                          : null),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
