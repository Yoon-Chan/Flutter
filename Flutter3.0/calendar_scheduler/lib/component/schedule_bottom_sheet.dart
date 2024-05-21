import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  String selectedColor = categoryColors.first;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 400,
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
          child: Column(
            children: [
              const _Time(),
              const SizedBox(height: 8.0),
              const _Content(),
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
              const _SaveButton()
            ],
          ),
        ),
      ),
    );
  }
}

typedef OnColorSelected = void Function(String color);

class _Time extends StatelessWidget {
  const _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
            child: CustomTextField(
              label: '시작 시간',
            )),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
            child: CustomTextField(
              label: '종료 시간',
            ))
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
      ),
    );
  }
}

class _Category extends StatelessWidget {
  final String selectColor;
  final OnColorSelected onTap;

  const _Category({
    super.key,
    required this.selectColor,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categoryColors
          .map(
            (e) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  onTap(e);
                },
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                      color: Color(int.parse('FF$e', radix: 16)),
                      shape: BoxShape.circle,
                      border: e == selectColor ? Border.all(
                          color: Colors.black,
                          width: 4.0
                      ) : null
                  ),
                ),
              ),
            ),
      )
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
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
