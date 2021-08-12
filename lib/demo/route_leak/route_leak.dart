import 'package:flutter/material.dart';

class RouteLeakPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RouteLeakPage"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RouteLeakPage()));
              },
              child: Text("Open New RouteLeakPage"),
            ),
          ],
        ),
      ),
    );
  }
}
