import 'package:flutter/material.dart';

class BottomNavigationView extends StatelessWidget {
  final List<Widget> _children;
  final double width;
  final double height;
  final Color color;

  const BottomNavigationView({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    // required this.boxShadow,
    required List<Widget> children,
  }) : _children = children;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        constraints: BoxConstraints(minWidth: width, minHeight: height),
        decoration: BoxDecoration(
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _children,
        ),
      ),
    );
  }
}
