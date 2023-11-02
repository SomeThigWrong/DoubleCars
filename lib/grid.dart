import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class VerticalLine extends RectangleComponent  {

  static final Paint blue = BasicPalette.white.paint();

  VerticalLine(Vector2 position, Vector2 shapeLine)
      : super(
    position: position,
    size: shapeLine,
    anchor: Anchor.topCenter,
    paint: blue
  );
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }
}