import 'package:flutter/material.dart';

// TODO: What is it for
class ScrollToHide extends StatefulWidget {
  const ScrollToHide({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final Widget child;
  final ScrollController controller;
  final Duration duration;

  @override
  State<ScrollToHide> createState() => _ScrollToHideState();
}

class _ScrollToHideState extends State<ScrollToHide> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    // ignore: unused_local_variable
    final direction = widget.controller.position.userScrollDirection;

    if (widget.controller.position.pixels >= 200) {
      show();
    } else {
      hide();
    }
  }

  void show() {
    if (!_isVisible) {
      setState(() {
        _isVisible = true;
      });
    }
  }

  void hide() {
    if (_isVisible) {
      setState(() {
        _isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: 0,
      child: Wrap(children: [widget.child]),
    );
  }
}
