import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.color,
      this.iconSize});

  final Widget icon;
  final void Function() onPressed;
  final Color? color;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      icon: icon,
      onPressed: onPressed,
      color: color,
      iconSize: iconSize,
    );
  }
}
