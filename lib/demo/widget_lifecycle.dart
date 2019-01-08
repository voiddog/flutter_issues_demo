///
/// ┏┛ ┻━━━━━┛ ┻┓
/// ┃　　　　　　 ┃
/// ┃　　　━　　　┃
/// ┃　┳┛　  ┗┳　┃
/// ┃　　　　　　 ┃
/// ┃　　　┻　　　┃
/// ┃　　　　　　 ┃
/// ┗━┓　　　┏━━━┛
/// * ┃　　　┃   神兽保佑
/// * ┃　　　┃   代码无BUG！
/// * ┃　　　┗━━━━━━━━━┓
/// * ┃　　　　　　　    ┣┓
/// * ┃　　　　         ┏┛
/// * ┗━┓ ┓ ┏━━━┳ ┓ ┏━┛
/// * * ┃ ┫ ┫   ┃ ┫ ┫
/// * * ┗━┻━┛   ┗━┻━┛
/// @author qigengxin
/// @since 2019-01-07 23:13
import 'package:flutter/material.dart';

class WidgetLifecycleDemo extends StatefulWidget {
  @override
  _WidgetLifecycleDemoState createState() => _WidgetLifecycleDemoState();
}

class _WidgetLifecycleDemoState extends State<WidgetLifecycleDemo> {

  static int _gPageId = 1;
  final int _pageId = _gPageId++;

  @override
  void initState() {
    super.initState();
    print('initState: page_${_pageId}');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate: page_${_pageId}');
  }

  @override
  Widget build(BuildContext context) {
    print('build: page_${_pageId}');
    return RepaintBoundary(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.of(context).pop();
          }),
          title: Text('WidgetLifecycleDemo'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("pageId: ${_pageId}"),
              RaisedButton(
                child: Text('Open a new Page'),
                onPressed: () {
                  Navigator.of(context).pushNamed('widget_lifecycle');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
