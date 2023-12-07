import 'package:flutter/material.dart';
import '../../common/constants/layout_constant.dart';

class PrimaryContainer extends StatelessWidget {
  final Widget? child;
  const PrimaryContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16),
      child: child,
    );
  }
}
