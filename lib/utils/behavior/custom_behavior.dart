import 'dart:ui';

import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  final ScrollPhysics? _physics;

  const CustomScrollBehavior([this._physics]);

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return _physics ?? super.getScrollPhysics(context);
  }

  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
        PointerDeviceKind.trackpad,
      };
}
