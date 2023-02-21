import 'package:flutter/material.dart';

class FlipCardContentWidget extends StatelessWidget {
  final double width;
  final double fontSize;
  final String content;

  const FlipCardContentWidget(
    this.width,
    this.fontSize,
    this.content, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      child: Text(
        content,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
