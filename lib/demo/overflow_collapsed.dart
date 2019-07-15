import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 折叠文字组件，exmaple 请看 `demo/collapsed_text_example.dart`
class CollapsedText extends StatefulWidget {
  /// 初始折叠状态
  final bool initCollapsed;

  /// 文本组件
  final Widget text;

  /// 开始折叠的高度
  final double collapsedSize;

  /// 底部遮罩，用于遮住截断的文字
  final Widget mask;

  /// 展开折起的按钮
  final Widget Function(
          BuildContext context, bool collapsed, ValueChanged<bool> callback)
      buttonBuilder;

  const CollapsedText(
      {Key key,
      this.initCollapsed = true,
      @required this.text,
      @required this.collapsedSize,
      this.mask = const _DefaultTextMask(),
      this.buttonBuilder = _defaultBuilder})
      : assert(text != null),
        assert(collapsedSize != null),
        assert(mask != null),
        assert(buttonBuilder != null),
        super(key: key);

  @override
  _CollapsedTextState createState() => _CollapsedTextState();

  static Widget _defaultBuilder(
      BuildContext context, bool collapsed, ValueChanged<bool> callback) {
    return ButtonTheme(
      minWidth: 0,
      height: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: FlatButton(
        child: collapsed
            ? Text(
                '展开',
                style: TextStyle(color: Colors.blue, fontSize: 12),
              )
            : Text(
                '收起',
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
        onPressed: () {
          callback(!collapsed);
        },
      ),
    );
  }
}

class _CollapsedTextState extends State<CollapsedText> {
  bool _collapsed;

  @override
  void initState() {
    super.initState();
    _collapsed = widget.initCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OverflowCollapsed(
          collapsed: _collapsed,
          collapsedSize: widget.collapsedSize,
          collapsedChild: widget.text,
          builder: (context, child, overflow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    child,
                    if (overflow && _collapsed)
                      Positioned(
                          left: 0, right: 0, bottom: 0, child: widget.mask)
                  ],
                ),
                if (overflow)
                  widget.buttonBuilder(context, _collapsed, _changeCollapsed)
              ],
            );
          },
        )
      ],
    );
  }

  void _changeCollapsed(bool value) {
    setState(() {
      _collapsed = value;
    });
  }
}

/// 默认的折叠遮罩
class _DefaultTextMask extends StatelessWidget {
  const _DefaultTextMask();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 15,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            gradient: LinearGradient(
                colors: [Colors.white.withAlpha(0), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)));
  }
}

/// 通用折叠组件
class OverflowCollapsed extends RenderObjectWidget {
  /// 是否折叠状态
  final bool collapsed;
  /// 折叠方向，默认垂直方向
  final Axis axis;
  /// 开始折叠的大小
  final double collapsedSize;
  /// 折叠儿子，此组件参与折叠，如果 overflow 而且处于折叠状态
  /// 会被 limit box 限制大小，此 widget 并不是当前 widget 的 child
  final Widget collapsedChild;
  /// [collapsedChild] 当前 widget 的 chid 构造器，参数中的 [child] 是 [collapsedChild]
  /// 上包装了一个 [_SizeLimit]
  final Function(BuildContext context, Widget child, bool isOverflow) builder;

  OverflowCollapsed(
      {Key key,
      @required this.collapsedSize,
      this.collapsed = true,
      this.axis = Axis.vertical,
      this.collapsedChild,
      this.builder})
      : assert(collapsedChild != null),
        assert(collapsedSize != null),
        super(key: key);

  @override
  _OverflowCollapsedRenderObject createRenderObject(BuildContext context) {
    return _OverflowCollapsedRenderObject();
  }

  @override
  void updateRenderObject(
      BuildContext context, _OverflowCollapsedRenderObject renderObject) {}

  @override
  RenderObjectElement createElement() {
    return _OverflowCollapsedElement(this);
  }
}

class _OverflowCollapsedRenderObject extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  bool _debugThrowIfNotCheckingIntrinsics() {
    assert(() {
      if (!RenderObject.debugCheckingIntrinsics) {
        throw FlutterError(
            'LayoutBuilder does not support returning intrinsic dimensions.\n'
            'Calculating the intrinsic dimensions would require running the layout '
            'callback speculatively, which might mutate the live render object tree.');
      }
      return true;
    }());
    return true;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    assert(_debugThrowIfNotCheckingIntrinsics());
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    assert(_debugThrowIfNotCheckingIntrinsics());
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    assert(_debugThrowIfNotCheckingIntrinsics());
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    assert(_debugThrowIfNotCheckingIntrinsics());
    return 0.0;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    return child?.hitTest(result, position: position) ?? false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) context.paintChild(child, offset);
  }

  @override
  void performLayout() {
    assert(_callback != null);
    // 这里需要布局两次，因为第一次布局才会知道 child 里面 collapsed 的 render object
    // 的大小
    int time = 2;
    while (time-- > 0) {
      invokeLayoutCallback(_callback);
      if (child == null) {
        size = constraints.biggest;
        return;
      }
      child.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child.size);
    }
  }

  LayoutCallback<BoxConstraints> _callback;

  _OverflowCollapsedRenderObject({bool collapsed = false});
}

class _OverflowCollapsedElement extends RenderObjectElement {
  _OverflowCollapsedElement(OverflowCollapsed widget) : super(widget);

  @override
  OverflowCollapsed get widget => super.widget;

  @override
  _OverflowCollapsedRenderObject get renderObject => super.renderObject;

  Element _child;

  @override
  void forgetChild(Element child) {
    assert(child == _child);
    _child = null;
  }

  @override
  void visitChildren(visitor) {
    if (_child != null) {
      visitor(_child);
    }
  }

  @override
  void mount(Element parent, newSlot) {
    super.mount(parent, newSlot);
    renderObject._callback = _layout;
  }

  @override
  void update(RenderObjectWidget newWidget) {
    super.update(newWidget);
    renderObject._callback = _layout;
    renderObject.markNeedsLayout();
  }

  @override
  void performRebuild() {
    renderObject.markNeedsLayout();
    super.performRebuild();
  }

  @override
  void unmount() {
    super.unmount();
    renderObject._callback = null;
  }

  @override
  void insertChildRenderObject(RenderObject child, slot) {
    final RenderObjectWithChildMixin<RenderObject> renderObject =
        this.renderObject;
    assert(slot == null);
    assert(renderObject.debugValidateChild(child));
    renderObject.child = child;
    assert(renderObject == this.renderObject);
  }

  @override
  void moveChildRenderObject(RenderObject child, slot) {
    assert(false);
  }

  @override
  void removeChildRenderObject(RenderObject child) {
    final _OverflowCollapsedRenderObject renderObject = this.renderObject;
    assert(renderObject.child == child);
    renderObject.child = null;
    assert(renderObject == this.renderObject);
  }

  void _layout(BoxConstraints constraints) {
    owner.buildScope(this, () {
      try {
        bool isOverflow;
        Widget built;
        _SizeLimitBox target = _findTargetRenderObject();
        switch (widget.axis) {
          case Axis.horizontal:
            isOverflow =
                (target?._childSize?.width ?? 0) > widget.collapsedSize;
            built = _SizeLimit(
              maxWidth:
                  widget.collapsed ? widget.collapsedSize : double.infinity,
              child: widget.collapsedChild,
            );
            break;
          case Axis.vertical:
            isOverflow =
                (target?._childSize?.height ?? 0) > widget.collapsedSize;
            built = _SizeLimit(
              maxHeight:
                  widget.collapsed ? widget.collapsedSize : double.infinity,
              child: widget.collapsedChild,
            );
            break;
        }
        if (widget.builder != null) {
          built = widget.builder(this, built, isOverflow);
        }
        _child = updateChild(_child, built, null);
      } catch (e, stack) {
        Widget built = ErrorWidget.builder(_debugReportException(
            ErrorDescription('building $widget'), e, stack));
        _child = updateChild(null, built, slot);
      }
    });
  }

  /// 查找 collapsed 的 render object
  _SizeLimitBox _findTargetRenderObject() {
    _SizeLimitBox ret;
    _dfsVisitChildren(this, (child) {
      RenderObject rb = child.findRenderObject();
      if (rb is _SizeLimitBox) {
        ret = rb;
      }
    });
    return ret;
  }

  void _dfsVisitChildren(Element start, Function(Element child) callback) {
    start.visitChildren((child) {
      callback(child);
      _dfsVisitChildren(child, callback);
    });
  }

  FlutterErrorDetails _debugReportException(
    DiagnosticsNode context,
    dynamic exception,
    StackTrace stack,
  ) {
    final FlutterErrorDetails details = FlutterErrorDetails(
      exception: exception,
      stack: stack,
      library: 'wdb business',
      context: context,
    );
    FlutterError.reportError(details);
    return details;
  }
}

class _SizeLimit extends LimitedBox {
  const _SizeLimit({
    Key key,
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
    Widget child,
  }) : super(key: key, maxWidth: maxWidth, maxHeight: maxHeight, child: child);

  @override
  RenderLimitedBox createRenderObject(BuildContext context) {
    return _SizeLimitBox(maxWidth: maxWidth, maxHeight: maxHeight);
  }
}

class _SizeLimitBox extends RenderLimitedBox {
  _SizeLimitBox({
    RenderBox child,
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
  }) : super(child: child, maxWidth: maxWidth, maxHeight: maxHeight);

  Size _childSize;

  @override
  void performLayout() {
    child.layout(constraints, parentUsesSize: true);
    _childSize = child?.size;
    super.performLayout();
  }
}
