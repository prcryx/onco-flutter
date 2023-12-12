import 'package:flutter/material.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CustomProgressIndicator extends StatelessWidget {
  final int completeCount;
  final int totalCount;

  const CustomProgressIndicator({
    required this.completeCount,
    required this.totalCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: LayoutConstants.dimen_8,
      percent: completeCount / totalCount,
      padding: EdgeInsets.zero,
      barRadius: const Radius.circular(LayoutConstants.dimen_4),
      backgroundColor:
          Theme.of(context).extension<CustomColorTheme>()!.auxiliaryColor,
      progressColor:
          Theme.of(context).extension<CustomColorTheme>()!.primaryColor!,
    );
  }
}
