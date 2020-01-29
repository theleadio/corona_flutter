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
    return Container(
      color: Colors.teal,
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 8.0,
      ),
      child: Text(
        _counter.evaluate(animation).toString(),
        style: TextStyle(
          fontSize: 88.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
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
