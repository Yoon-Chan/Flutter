import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/size.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  const CustomTextFormField(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(
          height: small_gap,
        ),
        TextFormField(
          validator: (value) =>
              value!.isEmpty ? "Please enter some text" : null,
          obscureText: text == "Password" ? true : false,
          decoration: InputDecoration(
              hintText: "Enter $text",
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  //손가락 터치시 TextFormField 디자인
                  borderRadius: BorderRadius.circular(20)),
              errorBorder: OutlineInputBorder(
                //에러 발생서 TextFormField 디자인
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                  //에러가 발생 후 손가락을 터치했을 때 TextFormField 디자인
                  borderRadius: BorderRadius.circular(20))),
        )
      ],
    );
  }
}
