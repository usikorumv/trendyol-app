import 'package:flutter/material.dart';

///Callback when child/parent is tapped . Map data will contain {String 'id',String 'parent_id',String 'title',Map 'extra'}

typedef OnTap = Function(Map data);

///A tree view that supports indefinite category/subcategory lists with horizontal and vertical scrolling
class DynamicTreeView extends StatefulWidget {
  ///DynamicTreeView will be build based on this.Create a model class and implement [BaseData]
  final List<BaseData> data;

  ///Called when DynamicTreeView parent or children gets tapped.
  ///Map will contain the following keys :
  ///id , parent_id , title , extra
  final OnTap? onTap;

  ///The width of DynamicTreeView
  final double width;

  ///Configuration object for [DynamicTreeView]
  final Config config;
  const DynamicTreeView({
    Key? key,
    required this.data,
    this.config = const Config(),
    this.onTap,
    this.width = 220.0,
  }) : super(key: key);

  @override
  _DynamicTreeViewOriState createState() => _DynamicTreeViewOriState();
}

class _DynamicTreeViewOriState extends State<DynamicTreeView> {
  late List<ParentWidget> treeView;
  final ChildTapListener _childTapListener = ChildTapListener();

  @override
  void initState() {
    _buildTreeView();
    _childTapListener.addListener(childTapListener);
    super.initState();
  }

  void childTapListener() {
    if (widget.onTap != null) {
      var k = _childTapListener.getMapValue();
      widget.onTap!(k);
    }
  }

  @override
  void dispose() {
    _childTapListener.removeListener(childTapListener);
    _childTapListener.dispose();
    super.dispose();
  }

  _buildTreeView() {
    var k = widget.data
        .where((data) {
          return data.getParentId() == widget.config.rootId;
        })
        .map((data) {
          return data.getId();
        })
        .toSet()
        .toList()
      ..sort((i, j) => i.compareTo(j));

    var widgets = <ParentWidget>[];
    for (var f in k) {
      ParentWidget p = buildWidget(f, "");
      widgets.add(p);
    }
    setState(() {
      treeView = widgets;
    });
  }

  ParentWidget buildWidget(String parentId, String name) {
    var data = _getChildrenFromParent(parentId);
    BaseData d =
        widget.data.firstWhere((d) => d.getId() == parentId.toString());
    name = d.getTitle();

    var p = ParentWidget(
      baseData: d,
      onTap: widget.onTap!,
      config: widget.config,
      children: _buildChildren(data),
      key: ObjectKey({
        'id': d.getId(),
        'parent_id': d.getParentId(),
        'title': d.getTitle(),
        'extra': '${d.getExtraData()}'
      }),
    );
    return p;
  }

  _buildChildren(List<BaseData> data) {
    var cW = <Widget>[];
    for (var k in data) {
      var c = _getChildrenFromParent(k.getId());
      if (c.isNotEmpty) {
        //has children
        var name = widget.data
            .firstWhere((d) => d.getId() == k.getId().toString())
            .getTitle();
        cW.add(buildWidget(k.getId(), name));
      } else {
        cW.add(Column(
          children: [
            ListTile(
              onTap: () {
                widget.onTap!({
                  'id': k.getId(),
                  'parent_id': k.getParentId(),
                  'title': k.getTitle(),
                  'extra': '${k.getExtraData()}'
                });
              },
              contentPadding: widget.config.childrenPaddingEdgeInsets,
              title: Text(
                k.getTitle(),
                style: widget.config.childrenTextStyle,
              ),
            ),
            const Divider(
              thickness: 1.2,
              indent: 16,
              endIndent: 16,
            ),
          ],
        ));
      }
    }
    return cW;
  }

  List<BaseData> _getChildrenFromParent(String parentId) {
    return widget.data
        .where((data) => data.getParentId() == parentId.toString())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: widget.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: treeView,
          ),
          physics: const BouncingScrollPhysics(),
        ),
      ),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
    );
  }
}

class ChildWidget extends StatefulWidget {
  final List<Widget> children;
  final bool shouldExpand;
  final Config config;
  const ChildWidget({
    Key? key,
    required this.children,
    this.shouldExpand = false,
    required this.config,
  }) : super(key: key);

  @override
  _ChildWidgetState createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> sizeAnimation;
  late AnimationController expandController;

  @override
  void didUpdateWidget(ChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldExpand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void initState() {
    prepareAnimation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    expandController.dispose();
  }

  void prepareAnimation() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    Animation curve =
        CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
    sizeAnimation =
        Tween(begin: 0.0, end: 1.0).animate(curve as Animation<double>)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: sizeAnimation,
      axisAlignment: -1.0,
      child: Column(
        children: _buildChildren(),
      ),
    );
  }

  _buildChildren() {
    return widget.children.map((c) {
      // return c;
      return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: widget.config.childrenPaddingEdgeInsets,
            child: c,
          ));
    }).toList();
  }
}

class ParentWidget extends StatefulWidget {
  final List<Widget> children;
  final BaseData baseData;
  final Config config;
  final OnTap onTap;
  const ParentWidget({
    Key? key,
    required this.children,
    required this.baseData,
    required this.config,
    required this.onTap,
  }) : super(key: key);

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget>
    with SingleTickerProviderStateMixin {
  bool shouldExpand = false;
  late Animation<double> sizeAnimation;
  late AnimationController expandController;

  @override
  void dispose() {
    super.dispose();
    expandController.dispose();
  }

  @override
  void initState() {
    prepareAnimation();
    super.initState();
  }

  void prepareAnimation() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    Animation curve =
        CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
    sizeAnimation =
        Tween(begin: 0.0, end: 0.5).animate(curve as Animation<double>)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
            ListTile(
              onTap: () {
                var map = <String, dynamic>{};
                map['id'] = widget.baseData.getId();
                map['parent_id'] = widget.baseData.getParentId();
                map['title'] = widget.baseData.getTitle();
                map['extra'] = widget.baseData.getExtraData();
                widget.onTap(map);
              },
              title: Text(widget.baseData.getTitle(),
                  style: widget.config.parentTextStyle),
              contentPadding: widget.config.parentPaddingEdgeInsets,
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    shouldExpand = !shouldExpand;
                  });
                  if (shouldExpand) {
                    expandController.forward();
                  } else {
                    expandController.reverse();
                  }
                },
                icon: RotationTransition(
                  turns: sizeAnimation,
                  child: widget.config.arrowIcon,
                ),
              ),
            ),
            const Divider(
              thickness: 1.2,
              indent: 16,
              endIndent: 20,
            ),
          ],
        ),
        ChildWidget(
          children: widget.children,
          config: widget.config,
          shouldExpand: shouldExpand,
        ),
      ],
    );
  }
}

///A singleton Child tap listener
class ChildTapListener extends ValueNotifier<Map<String, dynamic>> {
  /* static final ChildTapListener _instance = ChildTapListener.internal();

  factory ChildTapListener() => _instance;

  ChildTapListener.internal() : super(null); */

  ChildTapListener() : super({});

  void addMapValue(Map map) {
    value = map as Map<String, dynamic>;
    notifyListeners();
  }

  Map getMapValue() {
    return value;
  }
}

///Dynamic TreeView will construct treeview based on parent-child relationship.So, its important to
///override getParentId() and getId() with proper values.
abstract class BaseData {
  ///id of this data
  String getId();

  /// parentId of a child
  String getParentId();

  /// Text displayed on the parent/child tile
  String getTitle();

  ///Any extra data you want to get when tapped on children
  Map<String, dynamic> getExtraData();
}

class Config {
  final TextStyle parentTextStyle;
  final TextStyle childrenTextStyle;
  final EdgeInsets childrenPaddingEdgeInsets;
  final EdgeInsets parentPaddingEdgeInsets;

  ///Animated icon when tile collapse/expand
  final Widget arrowIcon;

  ///the rootid of a treeview.This is needed to fetch all the immediate child of root
  ///Default is 1
  final String rootId;

  const Config(
      {this.parentTextStyle =
          const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      this.parentPaddingEdgeInsets = const EdgeInsets.all(6.0),
      this.childrenTextStyle = const TextStyle(color: Colors.black),
      this.childrenPaddingEdgeInsets =
          const EdgeInsets.only(left: 15.0, top: 0, bottom: 0),
      this.rootId = "1",
      this.arrowIcon = const Icon(Icons.keyboard_arrow_down)});
}
