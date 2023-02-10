import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/component/custom_text_form_field.dart';
import 'package:flutter_login/size.dart';

class CustomForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField("Email"),
            SizedBox(
              height: medium_gap,
            ),
            CustomTextFormField('Password'),
            SizedBox(
              height: large_gap,
            ),
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //유효성 검사
                    Navigator.pushNamed(context, '/home');
                  }
                },
                child: Text("Login"))
          ],
        ));
  }
}
