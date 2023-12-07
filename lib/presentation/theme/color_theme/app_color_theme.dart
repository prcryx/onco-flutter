import 'package:flutter/widgets.dart';
import 'package:onco_connect/presentation/theme/app_colors.dart';

import 'custom_color_theme.dart';

const CustomColorTheme lightTheme = CustomColorTheme(
  scaffoldBackground: AppColor.paleGray,
  loginBg: AppColor.deutziaWhite,
  primaryColor: AppColor.copper,
  primaryLight: AppColor.berryCheesecake,
  complementaryColor: AppColor.deutziaWhite,
  auxiliaryColor: AppColor.oslo,
  auxiliaryBgColor: AppColor.silverMist,
  compliance: AppColor.spotlight,
  noncompliance: AppColor.jasper,
  cursorColor: AppColor.raven,
  primaryGradient: LinearGradient(
    colors: [
      AppColor.mintedLime,
      AppColor.sunlitSilk,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);
