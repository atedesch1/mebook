import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListWheelScrollViewHorizontal extends StatelessWidget {
  final Widget Function(BuildContext, int) builder;
  final Axis scrollDirection;
  final FixedExtentScrollController controller;
  final double itemExtent;
  final double diameterRatio;
  final double overAndUnderCenterOpacity;
  final double squeeze;
  final int childCount;
  final void Function(int) onSelectedItemChanged;
  const ListWheelScrollViewHorizontal({
    Key key,
    @required this.builder,
    @required this.itemExtent,
    this.squeeze = 1.0,
    this.overAndUnderCenterOpacity = 1.0,
    this.childCount = 0,
    this.controller,
    this.onSelectedItemChanged,
    this.scrollDirection = Axis.vertical,
    this.diameterRatio = 100000,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: scrollDirection == Axis.horizontal ? 3 : 0,
      child: ListWheelScrollView.useDelegate(
        squeeze: squeeze,
        overAndUnderCenterOpacity: overAndUnderCenterOpacity,
        onSelectedItemChanged: onSelectedItemChanged,
        controller: controller,
        itemExtent: itemExtent,
        diameterRatio: diameterRatio,
        physics: FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: childCount,
          builder: (context, index) {
            return RotatedBox(
              quarterTurns: scrollDirection == Axis.horizontal ? 1 : 0,
              child: builder(context, index),
            );
          },
        ),
      ),
    );
  }
}
