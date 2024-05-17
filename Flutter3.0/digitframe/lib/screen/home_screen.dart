import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          children: [1, 2, 3, 4, 5]
              .map((e) => Image.asset('asset/img/image_$e.jpeg', fit: BoxFit.cover,))
              .toList(),
        ),
      ),
    );
  }
}
