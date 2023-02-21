import 'package:flutter/material.dart';

class FlipCardMaskWidget extends StatelessWidget {
  final double width;
  final double height;

  const FlipCardMaskWidget(
    this.width,
    this.height, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      width: width,
      height: height,
    );
  }
}
