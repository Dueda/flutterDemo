import 'package:flutter/material.dart';

class TipRoute extends StatelessWidget {
  final String text;

  const TipRoute({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, "我是返回"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
