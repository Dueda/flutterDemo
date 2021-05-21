import 'package:flutter/material.dart';

class WrapTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WrapTest"),
      ),
      body: Wrap(
        spacing: 10,
        runSpacing: 10,
        runAlignment: WrapAlignment.center,
        children: <Widget>[
          Chip(
            label: Text("第一个"),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("A"),
            ),
          ),
          Chip(
            label: Text("第二个"),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("B"),
            ),
          ),
          Chip(
            label: Text("第三个"),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("C"),
            ),
          ),
          Chip(
            label: Text("第四个"),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("D"),
            ),
          ),
          Chip(
            label: Text("第五个"),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("E"),
            ),
          )
        ],
      ),
    );
  }
}
