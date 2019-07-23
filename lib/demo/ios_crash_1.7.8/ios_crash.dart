///
///
/// ┏┛ ┻━━━━━┛ ┻┓
/// ┃　　　　　　 ┃
/// ┃　　　━　　　┃
/// ┃　┳┛　  ┗┳　┃
/// ┃　　　　　　 ┃
/// ┃　　　┻　　　┃
/// ┃　　　　　　 ┃
/// ┗━┓　　　┏━━━┛
///   ┃　　　┃   神兽保佑
///   ┃　　　┃   代码无BUG！
///   ┃　　　┗━━━━━━━━━┓
///   ┃　　　　　　　    ┣┓
///   ┃　　　　         ┏┛
///   ┗━┓ ┓ ┏━━━┳ ┓ ┏━┛
///     ┃ ┫ ┫   ┃ ┫ ┫
///     ┗━┻━┛   ┗━┻━┛
/// 测试 iOS 在 1.7.8 上的 crash
/// Author: qigengxin (voiddog@foxmail.com)
/// File Created: Monday, 15th July 2019 10:14:33 am

import 'package:flutter/material.dart';
//图文卡片 type 0

class IOSCrashExample extends StatefulWidget {
  @override
  _IOSCrashExampleState createState() => _IOSCrashExampleState();
}

class _IOSCrashExampleState extends State<IOSCrashExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("iOS crash example"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: _buildChildren(context),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    return [
      for (int i = 0; i < 10; ++i)
        LayoutBuilder(
          builder: (context, constarints) {
            return _FollowFeedsMoreTextItem(
              content: "经典四口味尝鲜装\n玲珑心意小礼盒，第二件半价！！\n限时时间：截止至15日0点，快来抢购吧",
              tag: "第二件半价",
            );
          },
        ),
      for (int i = 0; i < 10; ++i)
        LayoutBuilder(
          builder: (context, constraints) {
            return _FollowFeedsMoreTextItem(
              content:
                  "夏日黄昏光晕法式少女\n\n【MINICYBER】太阳女神搭配  https://k.weidian.com/g0PDl=l9",
              tag: "心机耳饰",
            );
          },
        ),
    ];
  }
}

class _FollowFeedsMoreTextItemState extends State<_FollowFeedsMoreTextItem> {
  _FollowFeedsMoreTextItemState();

  @override
  Widget build(BuildContext context) {
    if (widget.content?.isNotEmpty != true && widget.tag?.isNotEmpty != true) {
      return Container();
    }

    return LayoutBuilder(builder: (context, size) {
      return Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text.rich(TextSpan(children: _buildText(context)))]));
    });
  }

  List<InlineSpan> _buildText(BuildContext context) {
    List<InlineSpan> result = [];
    String content = widget.content?.trim();

    //置顶标展示
    if (content?.isNotEmpty == true) {
      RegExp regExp = RegExp(
          "((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?");
      List<Match> matches = regExp.allMatches(content).toList();
      if (matches.length == 0) {
        //没有超链接
        result.add(TextSpan(
            text: content,
            style: TextStyle(
              color: Color(0xFF4A4A4A),
              fontSize: 14,
            )));
      } else {
        //有超链接
        int index = 0;
        for (int i = 0; i < matches.length; i++) {
          Match m = matches[i];
          if (m.start > index) {
            result.add(TextSpan(
                text: content.substring(index, m.start),
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: 14,
                )));
          }
          result.add(WidgetSpan(
            child: GestureDetector(
              child: Image.network(
                  "https://i.imgur.com/NvcObW8.png",
                  width: 14,
                  height: 18),
              onTap: () {},
            ),
          ));
          index = m.end;
        }
      }
    }
    return result;
  }
}

///卡片容器顶部文字收起展开组件
class _FollowFeedsMoreTextItem extends StatefulWidget {
  final String content;
  final String tag;
  final int maxLine;
  final String linkUrlText;

  _FollowFeedsMoreTextItem(
      {this.content, this.tag, this.maxLine = 3, this.linkUrlText = "网页链接"}) {}

  @override
  State<StatefulWidget> createState() {
    return _FollowFeedsMoreTextItemState();
  }
}
