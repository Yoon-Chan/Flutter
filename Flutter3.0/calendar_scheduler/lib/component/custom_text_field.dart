import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool expand;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.onSaved,
    required this.validator,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
        ),
        if(expand) Expanded(child: renderTextField()),
        if(!expand) renderTextField()

      ],
    );
  }


  Widget renderTextField(){
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
      //저장 했을 때
      onSaved: onSaved,
      //검증할 때 로직
      validator: validator,
      maxLines: expand ? null : 1,
      minLines: expand ? null : 1,
      expands: expand,
      cursorColor: Colors.grey,
    );
  }
}
