import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SubPage Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: FirstPage(),
        
        //rout를 이용한 페이지 이동하기
        initialRoute: '/',
        routes: {
          '/': (context) => FirstPage(),
          '/second': (context) => SecondPage()
        });
  }
}

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page Main'),
      ),
      body: Container(
        child: Center(
          child: Text('첫 번째 페이지'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //세컨드 페이지로 이동하는 방법
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => SecondPage(),));
          
          Navigator.of(context).pushNamed('/second');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secon Page'),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              //페이지 나가기
              Navigator.of(context).pop();
            },
            child: Text('돌아가기'),
          ),
        ),
      ),
    );
  }
}
