import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/app/dashboard/controller/dashboard_controller.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';

class BottomNavigationButton extends StatelessWidget {
  final IconData icon;
  final int uniqueIndex;
  final String title;
  final DashboardController controller;

  const BottomNavigationButton({
    Key? key,
    required this.icon,
    required this.uniqueIndex,
    required this.title,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final isSelected = uniqueIndex == controller.currentPageIndex.value;
    return Obx(
      () => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // debugPrint(
          //     "CURRENT INDEX===> ${controller.currentPageIndex.value} UNIQUE INDEX ==>$uniqueIndex");
          if (uniqueIndex != controller.currentPageIndex.value) {
            controller.onPageChange(
                uniqueIndex, controller.currentPageIndex.value);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Center(
                child: Icon(
                  icon,
                  size: LayoutConstants.dimen_24,
                  color: uniqueIndex == controller.currentPageIndex.value
                      ? Theme.of(context)
                          .extension<CustomColorTheme>()!
                          .primaryColor
                      : Theme.of(context)
                          .extension<CustomColorTheme>()!
                          .auxiliaryColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: uniqueIndex == controller.currentPageIndex.value
                  ? Theme.of(context)
                      .extension<CustomTextTheme>()!
                      .bodySrPrimary!
                  : Theme.of(context).extension<CustomTextTheme>()!.bodySrAux!,
            ),
          ],
        ),
      ),
    );
  }
}
