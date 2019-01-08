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
/// @since 2019-01-08 13:31
///
import 'package:flutter/material.dart';

class InkIssuesDemo extends StatefulWidget {
  @override
  _InkIssuesDemoState createState() => _InkIssuesDemoState();
}

class _InkIssuesDemoState extends State<InkIssuesDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.of(context).pop();
        }),
        title: Text('InkIssuesDemo'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('SettingA'),
            onTap: () {},
          ),
          ListTile(
            title: Text('SettingB'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Show Dialog'),
            onTap: () {
              _showDialog(context);
            },
          ),
          ListTile(
            title: Text('SettingD'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Rewind and remember'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You will never be satisfied.'),
              Text('You\’re like me. I’m never satisfied.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
