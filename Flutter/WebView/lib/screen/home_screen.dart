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
              icon: Icon(Icons.home,)),
          IconButton(onPressed: () {
            if (controller != null) {
              controller!.goBack();
            }
          }
              , icon: Icon(Icons.skip_previous_sharp)),

          IconButton(onPressed: () {
            if (controller != null) {
              controller!.goForward();
            }
          }
              , icon: Icon(Icons.skip_next_sharp)),
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
