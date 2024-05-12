import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomeScreen(),
    )
  );
}

//StatelessWidget
class HomeScreen extends StatelessWidget{
  //키 추가하기
  const HomeScreen({super.key});

  //필수 오버라이드 메서드
  //위젯을 반환해 줘야 한다.
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blue,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/image/logo.png',
              ),
              const SizedBox(
                height: 28.0,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      );
  }
}
