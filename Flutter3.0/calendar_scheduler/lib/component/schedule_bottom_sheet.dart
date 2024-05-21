import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDay;
  const ScheduleBottomSheet({
    required this.selectedDay,
    super.key
  });

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
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 400,
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _Time(
                  onEndSaved: onEndTimeSaved,
                  onEndValidate: onEndTimeValidate,
                  onStartSave: onStartTimeSaved,
                  onStartValidate: onStartTimeValidate,
                ),
                const SizedBox(height: 8.0),
                _Content(
                  onSaved: onContentSaved,
                  onValidate: onContentValidate,
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
  }

  onStartTimeSaved(String? val) {
    if (val == null) return;
    startTime = int.parse(val);
  }

  String? onStartTimeValidate(String? val) {
    if (val == null) return '값을 입력해 주세요!!';

    if(int.tryParse(val) == null) {
      return '숫자를 입력해 주세요!!';
    }
    final time = int.parse(val);

    if(time < 0 || time > 24) return '시간 범위가 맞지 않습니다!!';
    return null;
  }

  onEndTimeSaved(String? val) {
    if (val == null) return;
    endTime = int.parse(val);
  }

  String? onEndTimeValidate(String? val) {
    if (val == null) return '값을 입력해 주세요!!';

    if(int.tryParse(val) == null) {
      return '숫자를 입력해 주세요!!';
    }
    final time = int.parse(val);
    if(time < 0 || time > 24) return '시간 범위가 맞지 않습니다!!';
    return null;
  }

  onContentSaved(String? val) {
    if (val == null) return;
    content = val;
  }

  String? onContentValidate(String? val) {
    if (val == null) return '내용을 입력해 주세요!!';
    if( val.length < 5) return '5자 이상을 입력해 주세요';
    return null;
  }

  onSavePressed() {
    final isValid = formKey.currentState!.validate();
    if(isValid){
      formKey.currentState!.save();

      final schedule = Schedules(
        id: 999,
        startTime: startTime!,
        endTime: endTime!,
        content: content!,
        color: selectedColor,
        date: widget.selectedDay,
        createdAt: DateTime.now()
      );

      Navigator.of(context).pop(
        schedule
      );
    }
  }
}

typedef OnColorSelected = void Function(String color);

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSave;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndValidate;

  const _Time({
    super.key,
    required this.onStartSave,
    required this.onStartValidate,
    required this.onEndSaved,
    required this.onEndValidate,
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
        )),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
            child: CustomTextField(
          label: '종료 시간',
          onSaved: onEndSaved,
          validator: onEndValidate,
        ))
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;

  const _Content({
    super.key,
    required this.onSaved,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        validator: onValidate,
        onSaved: onSaved,
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
