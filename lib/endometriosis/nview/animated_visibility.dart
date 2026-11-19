import 'package:flutter/material.dart';

class AnimatedVisibility extends StatefulWidget {
  final Widget child;
  final bool visible;
  final Duration duration;
  final Offset offset;

  const AnimatedVisibility({
    Key? key,
    required this.child,
    required this.visible,
    this.duration = const Duration(milliseconds: 150),
    this.offset = const Offset(0, 1)
  }) : super(key: key);

  @override
  _AnimatedVisibilityState createState() => _AnimatedVisibilityState();
}

class _AnimatedVisibilityState extends State<AnimatedVisibility> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.visible ? 1.0 : 0.0,
      duration: widget.duration,
      child: AnimatedSlide(
        offset: widget.visible ? Offset.zero : widget.offset,
        duration: widget.duration,
        child: Visibility(
          visible: widget.visible,
          maintainState: false, // Keeps the widget's state when hidden
          child: widget.child,
        ),
      ),
    );
  }
}