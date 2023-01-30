import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime; // 시간 선택하는 텍스트 필드인지 여부
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),

        Expanded(
            flex: isTime? 0 : 1,
            child: TextFormField(
              onSaved: onSaved,
              validator: validator,
              cursorColor: Colors.grey,
              maxLines: isTime ? 1 : null,
              expands: !isTime, //시간 관련 텍스트 필드는 공간 최대 차지
              keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
              
              inputFormatters: isTime ? [
                FilteringTextInputFormatter.digitsOnly,
              ] : [],
              
              decoration: InputDecoration(
                border: InputBorder.none, //테두리 삭제
                filled: true, //배경색을 지정하겠다는 선언
                fillColor: Colors.grey[300],
                suffixText: isTime ? '시' : null, // 시간 관련 텍스트는 '시' 접미사 추가
              ),
              
            ), 
        ),  //폼 안에서 텍스트 필드를 쓸 때 사용
      ],

    );
  }
}
