import 'package:flutter/material.dart';

class TextFieldRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextFieldRouteState();
}

class _TextFieldRouteState extends State<TextFieldRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("TextField"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: TextField(
          textAlign: TextAlign.left,
          obscureText: true, //密码模式
          style: TextStyle(fontSize: 14, color: Colors.yellow),
          cursorColor: Colors.green,
          onChanged: (value) {},
          onEditingComplete: () {},
          decoration: InputDecoration(
            icon: Icon(Icons.home),
            counterText: "输入数量",
            labelText: "请输入",
            counterStyle: TextStyle(),
          ),
          controller: TextEditingController(),
        ),
      ),
    );
  }
}
