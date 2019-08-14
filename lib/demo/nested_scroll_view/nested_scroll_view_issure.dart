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
/// Author: qigengxin (voiddog@foxmail.com)
/// File Created: Wednesday, 14th August 2019 8:47:36 pm

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class NestedScrollIssure extends StatefulWidget {
  @override
  _NestedScrollIssureState createState() => _NestedScrollIssureState();
}

class _NestedScrollIssureState extends State<NestedScrollIssure> {
  List<String> _tabs = ["首页", "关注", "测试", "冒泡"];
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: _tabs.length,
          child: Builder(
            builder: (context) => _buildNestedScrollView(),
          )),
    );
  }

  Widget _buildNestedScrollView() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                title: Text('购物列表'),
                pinned: true,
                expandedHeight: 150,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  tabs: _tabs
                      .map((name) => Tab(
                            text: name,
                          ))
                      .toList(),
                ),
              ))
        ];
      },
      body: TabBarView(
        children: _tabs.map((name) {
          return PagingPage(
            key: PageStorageKey<String>(name),
            pageName: name,
          );
        }).toList(),
      ),
    );
  }
}

class PagingPage extends StatefulWidget {
  final String pageName;

  PagingPage({Key key, this.pageName}) : super(key: key);

  @override
  _PagingPageState createState() => _PagingPageState();
}

class _PagingPageState extends State<PagingPage> {
  List<String> _data;

  @override
  void initState() {
    super.initState();
    _data = [];
    for (int i = 0; i < 50; ++i) {
      _data.add("我是数据 $i");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TransitionBuilder> builder = [
      _buildContentList,
    ];
    return builder.reduce((value, next) {
      return (BuildContext context, Widget child) {
        child = value(context, child);
        return next(context, child);
      };
    })(context, null);
  }

  Widget _buildContentList(BuildContext context, Widget child) {
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
              child: ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text(_data[index]),
              ),
            );
          }, childCount: _data == null ? 0 : _data.length),
        ),
      ],
    );
  }
}
