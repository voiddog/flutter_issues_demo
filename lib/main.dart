import 'package:flutter/material.dart';
import 'demo/widget_lifecycle.dart';
import 'demo/ink_issues.dart';
import 'demo/ios_crash_1.7.8/ios_crash.dart';
import 'demo/nested_scroll_view/nested_scroll_view_issure.dart';
import 'demo/anroid_input_lost/android_input_lost.dart';

void main() {
  var mapRoutes = {
    "widget_lifecycle": (BuildContext context) {
      return WidgetLifecycleDemo();
    },
    "ink_issues": (BuildContext context) {
      return InkIssuesDemo();
    },
    "ios_carsh": (BuildContext context) {
      return IOSCrashExample();
    },
    "nested_scroll_issure": (BuildContext context) {
      return NestedScrollIssure();
    },
    "android_input_lost": (BuildContext context) {
      return AndroidInputLostDemo();
    }
  };
  runApp(MaterialApp(
    routes: mapRoutes,
    home: Home(mapRoutes: mapRoutes,),
  ));
}

class Home extends StatefulWidget {
  final Map<String, WidgetBuilder> mapRoutes;

  const Home({Key key, this.mapRoutes}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(mapRoutes);
}

class _HomeState extends State<Home> {
  Map<String, WidgetBuilder> mapRoutes;

  _HomeState(this.mapRoutes);

  @override
  Widget build(BuildContext context) {
    var routeList = mapRoutes.keys.toList();
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter issure demo'),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: routeList.length,
            itemBuilder: (context, index) {
              var routeName = routeList[index];
              return RaisedButton(onPressed: (){
                Navigator.of(context).pushNamed(routeName);
              }, child: Text(routeName),);
            })
    );
  }
}
