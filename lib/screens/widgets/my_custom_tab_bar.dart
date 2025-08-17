import 'package:flutter/material.dart';

class MyCustomTabBar<T> extends StatefulWidget {
  const MyCustomTabBar({
    super.key,
    this.controller,
    this.controllerPage,
    this.tabs,
    this.items,
    this.backagroundColor,
    this.indicator,
    this.onTap,
  }) : assert(tabs == null || items == null);

  final TabController? controller;
  final PageController? controllerPage;
  final List<Tab>? tabs;
  final List<String>? items;
  final Color? backagroundColor;
  final BoxDecoration? indicator;
  final ValueChanged<int>? onTap;
  @override
  State<MyCustomTabBar<T>> createState() => _MyCustomTabBarState<T>();
}

class _MyCustomTabBarState<T> extends State<MyCustomTabBar<T>>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int? length;
  @override
  void initState() {
    super.initState();
    length = widget.tabs?.length ?? widget.items?.length;
    if (widget.controller != null) {
      _controller = widget.controller;
    } else {
      _controller ??= TabController(length: length ?? 0, vsync: this);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color kColors = Color.fromARGB(255, 255, 255, 255);
    const Color kColors3 = Color(0xFFBDBDBD);

    return Container(
      decoration: BoxDecoration(color: widget.backagroundColor),
      child: TabBar(
        controller: _controller,
        isScrollable: false,
        labelColor: kColors,
        unselectedLabelColor: kColors3,
        dividerHeight: 40,
        dividerColor: widget.backagroundColor,
        labelStyle: TextStyle(fontSize: 16),
        indicatorWeight: 0.3,
        indicatorPadding: EdgeInsetsGeometry.symmetric(horizontal: 25),
        tabAlignment: TabAlignment.fill,
        indicatorSize: TabBarIndicatorSize.tab,
        onTap:
            widget.onTap ??
            (value) {
              widget.controllerPage?.animateToPage(
                value,
                duration: Durations.medium4,
                curve: Curves.ease,
              );
            },
        tabs:
            widget.tabs?.map((e) => e).toList() ??
            widget.items?.map((e) => Tab(text: e)).toList() ??
            [],
      ),
    );
  }
}
