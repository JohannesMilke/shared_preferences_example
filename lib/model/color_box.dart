import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ColorBox {
  final String name;
  final Color color;

  const ColorBox({
    @required this.name,
    @required this.color,
  });
}
