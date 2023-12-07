import 'package:flutter/material.dart';

class CustomColorTheme extends ThemeExtension<CustomColorTheme> {
  const CustomColorTheme({
    this.scaffoldBackground,
    this.loginBg,
    this.primaryColor,
    this.primaryLight,
    this.complementaryColor,
    this.auxiliaryColor,
    this.auxiliaryBgColor,
    this.compliance,
    this.noncompliance,
    this.cursorColor,
    this.primaryGradient,
  });
  final Color? scaffoldBackground;
  final Color? loginBg;
  final Color? primaryColor;
  final Color? primaryLight;
  final Color? complementaryColor;
  final Color? auxiliaryColor;
  final Color? auxiliaryBgColor;
  final Color? compliance;
  final Color? noncompliance;
  final Color? cursorColor;
  final LinearGradient? primaryGradient;
  @override
  CustomColorTheme copyWith({
    Color? scaffoldBackground,
    Color? loginBg,
    Color? primaryColor,
    Color? primaryLight,
    Color? complementaryColor,
    Color? auxiliaryColor,
    Color? auxiliaryBgColor,
    Color? compliance,
    Color? noncompliance,
    Color? cursorColor,
    LinearGradient? primaryGradient,
  }) {
    return CustomColorTheme(
      scaffoldBackground: scaffoldBackground,
      loginBg: loginBg,
      primaryColor: primaryColor,
      primaryLight: primaryLight,
      complementaryColor: complementaryColor,
      auxiliaryColor: auxiliaryColor,
      auxiliaryBgColor: auxiliaryBgColor,
      compliance: compliance,
      noncompliance: noncompliance,
      cursorColor: cursorColor,
      primaryGradient: primaryGradient,
    );
  }

  @override
  CustomColorTheme lerp(ThemeExtension<CustomColorTheme>? other, double t) {
    if (other is! CustomColorTheme) {
      return this;
    }
    return CustomColorTheme(
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t),
      loginBg: Color.lerp(loginBg, other.loginBg, t),
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t),
      complementaryColor:
          Color.lerp(complementaryColor, other.complementaryColor, t),
      auxiliaryColor: Color.lerp(auxiliaryColor, other.auxiliaryColor, t),
      auxiliaryBgColor: Color.lerp(auxiliaryBgColor, other.auxiliaryBgColor, t),
      compliance: Color.lerp(compliance, other.compliance, t),
      noncompliance: Color.lerp(noncompliance, other.noncompliance, t),
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t),
      primaryGradient:
          LinearGradient.lerp(primaryGradient, other.primaryGradient, t),
    );
  }
}
