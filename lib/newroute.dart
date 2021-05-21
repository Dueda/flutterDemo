import 'package:flutter/material.dart';

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Route"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("我是新的界面"),
          ElevatedButton(
              onPressed: () async {
                // var result = await Navigator.push(context,
                //     MaterialPageRoute(builder: (context) {
                //   return TipRoute(
                //     text: "我是提示",
                //   );
                // }));
                var result = await Navigator.pushNamed(context, "tip_page",
                    arguments: "我是路由注册传递的参数");
                print("路由返回值: $result");
              },
              child: Text("打开提示页")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "context_page");
              },
              child: Text("Context获取父类的标题")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "flex_page");
              },
              child: Text("FlexTest")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "wrap_page");
              },
              child: Text("WrapTest")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "flow_page");
              },
              child: Text("FlowTest")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "stack_page");
              },
              child: Text("stack_page")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "DecoratedBox_page");
              },
              child: Text("DecoratedBox")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "scaffold_page");
              },
              child: Text("抽屉以及tabView")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "clip_page");
              },
              child: Text("裁剪练习")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "singleScroller_page");
              },
              child: Text("不复用的滚动式图")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "listView1_page");
              },
              child: Text("ListViewTest1")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "listView2_page");
              },
              child: Text("ListViewTest带分隔线")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "scrollcontroller_page");
              },
              child: Text("ScrollController监听")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "scrollNotification_page");
              },
              child: Text("滚动通知Listener监听")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "poptest_page");
              },
              child: Text("返回监听")),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "inherited_page");
              },
              child: Text("共享数据")),
        ],
      )),
    );
  }
}
