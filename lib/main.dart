import 'dart:async';

import 'package:demo/ScrollerViewTest.dart';
import 'package:demo/TipRoute.dart';
import 'package:demo/backTest.dart';
import 'package:demo/clipTest.dart';
import 'package:demo/contextRoute.dart';
import 'package:demo/decoratedBoxTest.dart';
import 'package:demo/flexTest.dart';
import 'package:demo/flowTest.dart';
import 'package:demo/loginTest.dart';
import 'package:demo/newroute.dart';
import 'package:demo/progressRoute.dart';
import 'package:demo/rowroute.dart';
import 'package:demo/scaffoldRoute.dart';
import 'package:demo/scrollControllertest.dart';
import 'package:demo/scrollListener.dart';
import 'package:demo/shareData.dart';
import 'package:demo/stackTest.dart';
import 'package:demo/switchAndCheckBox.dart';
import 'package:demo/tapbox.dart';
import 'package:demo/textFileld.dart';
import 'package:demo/wrapTest.dart';
import 'package:flutter/material.dart';
import 'package:demo/rundomword.dart';

void collectLog(String line) {
//收集错误日志
}
void reportErrorAndLog(FlutterErrorDetails details) {
  //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  // 构建错误信息
  return null;
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };
  runZoned(
    () => runApp(MyApp()),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line); // 收集日志
      },
    ),
    // ignore: deprecated_member_use
    onError: (Object obj, StackTrace stack) {
      var details = makeDetails(obj, stack);
      reportErrorAndLog(details);
    },
  );
  // runZonedGuarded(() => runApp(MyApp()), (error, stack) {
  //   print(error.toString() + "--" + stack.toString());
  // });

  // runZoned(() =>runApp(MyApp()), zoneSpecification: new ZoneSpecification(
  //   print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
  //       parent.print(zone, "Intercepted: $line");
  //     }
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // routes: {
      //   "new_page": (context) => NewRoute(),
      //   "tip_page": (context) => TipRoute(text: ModalRoute.of(context).settings.arguments)
      // },
      onGenerateRoute: (settings) {
        String name = settings.name;
        switch (name) {
          case "new_page":
            return MaterialPageRoute(builder: (context) {
              return NewRoute();
            });
            break;
          case "tip_page":
            return MaterialPageRoute(builder: (context) {
              return TipRoute(text: settings.arguments.toString());
            });
            break;
          case "context_page":
            return MaterialPageRoute(builder: (context) {
              return ContextRoute();
            });
            break;
          case "tapBoxA_page":
            return MaterialPageRoute(builder: (context) {
              return TapBoxA();
            });
            break;
          case "tapBoxB_page":
            return MaterialPageRoute(builder: (context) {
              return ParentWidget();
            });
            break;
          case "tapBoxC_page":
            return MaterialPageRoute(builder: (context) {
              return ParentWidgetC();
            });
            break;
          case "switchAndCheckBox_page":
            return MaterialPageRoute(builder: (context) {
              return SwitchAndCheckBox();
            });
            break;
          case "textfield_page":
            return MaterialPageRoute(builder: (context) {
              return TextFieldRoute();
            });
            break;
          case "login_page":
            return MaterialPageRoute(builder: (context) {
              return LoginVC();
            });
            break;

          case "progress_page":
            return MaterialPageRoute(builder: (context) {
              return ProgressRoute();
            });
            break;
          case "row_page":
            return MaterialPageRoute(builder: (context) {
              return RowRoute();
            });
            break;
          case "flex_page":
            return MaterialPageRoute(builder: (context) {
              return FlexLayoutTestRoute();
            });
            break;
          case "wrap_page":
            return MaterialPageRoute(builder: (context) {
              return WrapTestRoute();
            });
            break;
          case "flow_page":
            return MaterialPageRoute(builder: (context) {
              return FlowTestRoute();
            });
            break;
          case "stack_page":
            return MaterialPageRoute(builder: (context) {
              return StackTestRoute();
            });
            break;
          case "DecoratedBox_page":
            return MaterialPageRoute(builder: (context) {
              return DecoratedBoxTestRoute();
            });
            break;
          case "scaffold_page":
            return MaterialPageRoute(builder: (context) {
              return ScaffoldRoute();
            });
            break;
          case "clip_page":
            return MaterialPageRoute(builder: (context) {
              return ClipTestRoute();
            });
            break;
          case "singleScroller_page":
            return MaterialPageRoute(builder: (context) {
              return SingleChildScrollViewTestRoute();
            });
            break;
          case "listView1_page":
            return MaterialPageRoute(builder: (context) {
              return ListViewTestRoute();
            });
            break;
          case "listView2_page":
            return MaterialPageRoute(builder: (context) {
              // return ListViewWithSperatorTestRoute();
              // return ListViewTest2();
              // return GridListViewTest();
              return SliverTestRoute();
            });
            break;
          case "scrollcontroller_page":
            return MaterialPageRoute(builder: (context) {
              // return ListViewWithSperatorTestRoute();
              // return ListViewTest2();
              // return GridListViewTest();
              return ScrollControllerTestRoute();
            });
            break;
          case "scrollNotification_page":
            return MaterialPageRoute(builder: (context) {
              // return ListViewWithSperatorTestRoute();
              // return ListViewTest2();
              // return GridListViewTest();
              return ScrollNotificationTestRoute();
            });
            break;
          case "poptest_page":
            return MaterialPageRoute(builder: (context) {
              // return ListViewWithSperatorTestRoute();
              // return ListViewTest2();
              // return GridListViewTest();
              return WillPopScopeTestRoute();
            });
          case "inherited_page":
            return MaterialPageRoute(builder: (context) {
              // return ListViewWithSperatorTestRoute();
              // return ListViewTest2();
              // return GridListViewTest();
              return InheritedWidgetTestRoute();
            });
            break;
          default:
            return MaterialPageRoute(builder: (BuildContext context) {
              return Scaffold(
                  body: Center(
                child: Text("Page not found"),
              ));
            });
        }
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "new_page");
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return NewRoute();
                // }));
              },
              child: Text("open new route"),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.black),
                  backgroundColor:
                      MaterialStateProperty.resolveWith((states) => Colors.red),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 12, color: Colors.yellow))),
            ),
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushNamed(context, "tapBoxA_page");
                }),
            IconButton(
                icon: Icon(Icons.mic_none),
                onPressed: () {
                  Navigator.pushNamed(context, "tapBoxB_page");
                }),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.pushNamed(context, "tapBoxC_page");
                }),
            IconButton(
                icon: Icon(Icons.switch_left),
                onPressed: () {
                  Navigator.pushNamed(context, "switchAndCheckBox_page");
                }),
            IconButton(
                icon: Icon(Icons.text_fields),
                onPressed: () {
                  Navigator.pushNamed(context, "textfield_page");
                }),
            IconButton(
                icon: Icon(Icons.login),
                onPressed: () {
                  Navigator.pushNamed(context, "login_page");
                }),
            IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  Navigator.pushNamed(context, "progress_page");
                }),
            IconButton(
                icon: Icon(Icons.icecream),
                onPressed: () {
                  Navigator.pushNamed(context, "row_page");
                }),
            Image.network(
              "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
              width: 100,
              height: 200,
            ),
            RandomWordsWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
