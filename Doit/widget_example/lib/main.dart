import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Widget Example';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WidgetApp(),
    );
  }
}

class WidgetApp extends StatefulWidget {
  const WidgetApp({super.key});

  @override
  State<WidgetApp> createState() => _WidgetApp();
}

class _WidgetApp extends State<WidgetApp> {
  String sum = '';
  List _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  List<DropdownMenuItem<String>> _dropDownMenuItems =
      new List.empty(growable: true);
  String? _buttonText;


  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();


  @override
  void initState() {
    super.initState();

    for(var item in _buttonList){
      _dropDownMenuItems.add(DropdownMenuItem(
          value: item,
          child: Text(item),
      ));
    }

    _buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Widget Example"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    '결과 : $sum',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: value1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: value2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        var value1Int = double.parse(value1.value.text);
                        var value2Int = double.parse(value2.value.text);

                        var res;
                        if(_buttonText == '더하기'){
                          res = value1Int + value2Int;
                        }else if(_buttonText == '빼기'){
                          res = value1Int - value2Int;
                        }else if(_buttonText == '곱하기'){
                          res = value1Int * value2Int;
                        }else
                          res = value1Int / value2Int;

                        sum = '$res';
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text(_buttonText!),
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: DropdownButton(
                    items: _dropDownMenuItems,
                    onChanged: (value) {
                      setState(() {
                        _buttonText = value;
                      });
                    },
                    value: _buttonText,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
