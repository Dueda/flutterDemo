import 'package:flutter/material.dart';

class SingleChildScrollViewTestRoute extends StatelessWidget {
  //单一的 不可复用的滚动式图
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scaffold(
      appBar: AppBar(
        title: Text("不可复用的滚动"),
      ),
      body: Scrollbar(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
              children: str
                  .split("")
                  .map((e) => Text(
                        e,
                        textScaleFactor: 2.0,
                      ))
                  .toList()),
        ),
      )),
    );
  }
}

//listView
class ListViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListViewTest1"),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemExtent: 44,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("$index"));
        },
      ),
    );
  }
}

class ListViewWithSperatorTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //下划线widget预定义以供复用。
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(color: Colors.green);
    return Scaffold(
      appBar: AppBar(
        title: Text("ListViewTest2"),
      ),
      body: ListView.separated(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("$index"));
        },
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
      ),
    );
  }
}

class ListViewTest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("带header和footer的列表"),
      ),
      body: Column(
        children: [
          Text("我是头"),
          Expanded(
              child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text("$index"));
            },
            itemCount: 100,
            itemExtent: 44,
          )),
          Text("我是footer")
        ],
      ),
    );
  }
}

//GirdView count extend
class GridListViewTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GridListViewTestState();
}

class _GridListViewTestState extends State<GridListViewTest> {
  List<IconData> _icons = [];
  @override
  void initState() {
    super.initState();
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GridView练习"),
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //每行三列
                childAspectRatio: 1.0 //显示区域宽高相等
                ),
            itemCount: _icons.length,
            itemBuilder: (context, index) {
              //如果显示到最后一个并且Icon总数小于200时继续获取数据
              if (index == _icons.length - 1 && _icons.length < 200) {
                _retrieveIcons();
              }
              return Icon(_icons[index]);
            }));
  }

  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 1)).then((value) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}

//自定义的滚动控件 组合 Sliver

class SliverTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
                title: Text("SliverAppBar"),
                background: Image.network(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
                  fit: BoxFit.cover,
                )),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.cyan[100 * (index % 9)],
                  child: new Text('List item $index'),
                );
              }, childCount: 50),
              itemExtent: 50)
        ],
      ),
    );
  }
}
