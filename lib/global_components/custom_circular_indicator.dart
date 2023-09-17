import 'package:flutter/material.dart';

class CustomCircularIndicator extends StatelessWidget {
  final Color color;
  final double height;

  const CustomCircularIndicator(
      {super.key, this.color = Colors.blue, this.height = 20.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: height,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: color,
        ));
  }
}
