import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Function onPressed;

  const CircularIconButton({super.key, required this.iconData, required this.iconSize, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle
      ),
      child: IconButton(
        icon: Icon(iconData),
        iconSize: iconSize,
        onPressed: onPressed(),
        color: Colors.black,
      ),
    );
  }
}
