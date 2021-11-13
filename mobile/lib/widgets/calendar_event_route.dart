import 'package:flutter/material.dart';
import 'dart:ui';

class ChangeEventRoute<T> extends PageRoute<T> {
  ChangeEventRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
  })  : _builder = builder,
        super(settings: settings);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Change event open';
}
