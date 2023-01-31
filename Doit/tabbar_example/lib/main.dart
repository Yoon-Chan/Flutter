import 'package:flutter/material.dart';
import 'package:tabbar_example/sub/firstpage.dart';
import 'package:tabbar_example/sub/secondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('TabBar Example'),
      ),
      body: TabBarView(
        children: [FirstApp(), SecondApp()],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.looks_one, color: Colors.blue,), ),
          Tab(icon: Icon(Icons.looks_two, color: Colors.blue,),),
        ],
        controller: controller,
      ),
    );
  }


  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
