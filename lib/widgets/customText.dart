import 'package:flutter/material.dart';

class Customtext extends StatelessWidget {
  const Customtext({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight,
  });
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: size, color: color, fontWeight: weight),
    );
  }
}
