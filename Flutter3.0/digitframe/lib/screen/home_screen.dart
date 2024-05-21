import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Timer? timer;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      int currentPage = controller.page == null ? 0 : controller.page!.toInt();
      int nextPage = (currentPage + 1) % 4;

      controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          children: [1, 2, 3, 4, 5]
              .map((e) =>
              Image.asset('asset/img/image_$e.jpeg', fit: BoxFit.cover,))
              .toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    controller.dispose();
  }
}
