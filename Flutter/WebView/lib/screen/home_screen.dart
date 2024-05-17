import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController? controller; // 컨트롤러 변수 생성

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,

        title: Text("Code Factory"),

        //가운데 정렬
        centerTitle: true,

        actions: [
          IconButton(
              onPressed: () {
                if (controller != null) {
                  controller!.loadUrl("https://blog.codefactory.ai");
                }
              },
              icon: Icon(
                Icons.home,
              )),
          IconButton(
              onPressed: () {
                if (controller != null) {
                  controller!.goBack();
                }
              },
              icon: Icon(Icons.skip_previous_sharp)),
          IconButton(
              onPressed: () {
                if (controller != null) {
                  controller!.goForward();
                }
              },
              icon: Icon(Icons.skip_next_sharp)),
        ],
      ),
      body: WebView(
        initialUrl: 'https://blog.codefactory.ai',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          this.controller = controller; //위젯에 컨트롤러 저장
        },
      ),
    );
  }
}

class FloatingActionButtonExample extends StatelessWidget {
  const FloatingActionButtonExample({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          //클릭했을 때 실행할 함수
          onPressed: () {},
          child: Text('클릭'),
        ),
        body: Container(
          //스타일 적용
          decoration: BoxDecoration(
            //배경 색깔 적용
            color: Colors.red,
            //테두리 적용
            border: Border.all(
                //테두리 굵기
                width: 16.0,
                //테두리 색상
                color: Colors.black),
            //모서리 라운드 처리
            borderRadius: BorderRadius.circular(16.0),
          ),
          width: 200.0,
          height: 100.0,

        ),
      ),
    );
  }
}
