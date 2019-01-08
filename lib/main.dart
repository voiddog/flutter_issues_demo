import 'package:flutter/material.dart';
import 'demo/widget_lifecycle.dart';
import 'demo/ink_issues.dart';

void main() {
  var mapRoutes = {
    "widget_lifecycle": (BuildContext context) {
      return WidgetLifecycleDemo();
    },
    "ink_issues": (BuildContext context) {
      return InkIssuesDemo();
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
