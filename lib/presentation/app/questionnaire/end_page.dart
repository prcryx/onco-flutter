import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';
import 'package:onco_connect/presentation/widgets/primary_button.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).extension<CustomColorTheme>()!.loginBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color:
                  Theme.of(context).extension<CustomColorTheme>()!.compliance,
              size: LayoutConstants.dimen_102,
            ),
            const LVSpacer(),
            Text('Thank You!',
                style:
                    Theme.of(context).extension<CustomTextTheme>()!.headingLb),
            const RVSpacer(),
            Text('Your answer is stored.',
                style: Theme.of(context).extension<CustomTextTheme>()!.bodyLr),
            const LVSpacer(),
            PrimaryButton(
              onTap: () {
                Get.back();
              },
              label: 'Go Back',
            ),
          ],
        ),
      ),
    );
  }
}
