


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LargeFileMain extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _LargeFileMain();

}


class _LargeFileMain extends State<LargeFileMain>{

  //내려받을 이미지 주소
  // final imgUrl =
  //     'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg'
  //     '?auto=compress';


  TextEditingController? controller;


  @override
  void initState() {

    super.initState();

    controller = TextEditingController(
      text: 'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg'
            '?auto=compress'
    );
  }

  bool downloading = false; //지금 내려받는 중인지 확인하는 변수
  var progressString ="";  //얼마나 내려받았는지 표시하는 변수
  String file = "";  //내려받은 파일


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: TextStyle(color: Colors.white),
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'url을 입력하세요'),
        ),
      ),
      body: Center(
        child: downloading ?
        Container(
          height: 120.0,
          width: 200.0,
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Downloading File : $progressString',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        )
        : FutureBuilder(
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.none :
                print('none');
                return Text('데이터 없음');
              case ConnectionState.waiting :
                print('waiting');
                return CircularProgressIndicator();
              case ConnectionState.active :
                print('active');
                return CircularProgressIndicator();
              case ConnectionState.done:
                print('done');
                if(snapshot.hasData){
                  return snapshot.data as Widget;
                }
            }

            print('end process');
            return Text('데이터 없음');
          },
        future: downloadWiget(file),
        ) ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },
        child: Icon(Icons.file_download),
      ),
    );

  }

  Future<Widget> downloadWiget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict(); //캐시 초기화하기

    if(exist) {
      return Center(
        child: Column(
          children: [
            Image.file(File(filePath)),
          ],
        ),
      );

    }else{
      return Text('No Data');
    }
  }


  Future<void> downloadFile() async {
    Dio dio = Dio();

    try{
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(controller!.value.text, '${dir.path}/myimage.jpg',
      onReceiveProgress: (count, total) {
        print('Count : $count ,  Total : $total');
        file = '${dir.path}/myimage.jpg';
        setState(() {
          downloading = true;
          progressString = ((count / total) * 100).toStringAsFixed(0) +'%';
        });
      },);

    }catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = 'Completed';
    });
    print('Download completed');
  }
}