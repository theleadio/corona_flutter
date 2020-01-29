import 'package:flutter/material.dart';

class Counter extends ImplicitlyAnimatedWidget {
  final int number;

  Counter({
    Key key,
    @required this.number,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
        );

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _CounterState();
}

class _CounterState extends ImplicitlyAnimatedWidgetState<Counter> {
  IntTween _counter;

  @override
  Widget build(BuildContext context) {
    return Text(_counter.evaluate(animation).toString());
  }

  @override
  void forEachTween(visitor) {
    _counter = visitor(
      _counter,
      widget.number,
      (value) => IntTween(begin: value),
    );
  }
}
