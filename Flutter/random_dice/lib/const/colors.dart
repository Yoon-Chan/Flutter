

import 'dart:ui';

import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF0E0E); //배경 색
const primaryColor = Colors.white; // 주 색상


//왜 이 변수만 final인 이유는 Colors.grey는 const로 선언 가능하지만 [600] 이라는 키값을 입력하면 런타임에 색상이 계산되기 때문에
// const 사용이 불가능하다. 그래서 final을 사용한다.
final secondaryColor = Colors.grey[600]; // 보조 색상