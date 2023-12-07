import 'package:flutter/material.dart';

class CustomTextTheme extends ThemeExtension<CustomTextTheme> {
  const CustomTextTheme({
    this.displayLr,
    this.displayMm,
    this.headingLr,
    this.bodyLr,
    this.bodyLrOnPrimary,
    this.bodyLm,
    this.bodyLmOnPrimary,
    this.bodyLb,
    this.bodyLbOnPrimary,
    this.bodyLbDisabled,
    this.bodyMr,
    this.bodyMrHint,
    this.bodyMm,
    this.bodyMb,
    this.bodySr,
    this.bodySrPrimary,
    this.bodySrAux,
    this.bodySm,
    this.bodySmDisabled,
  });
  final TextStyle? displayLr;
  final TextStyle? displayMm;
  final TextStyle? headingLr;
  final TextStyle? bodyLr;
  final TextStyle? bodyLrOnPrimary;
  final TextStyle? bodyLm;
  final TextStyle? bodyLmOnPrimary;
  final TextStyle? bodyLb;
  final TextStyle? bodyLbOnPrimary;
  final TextStyle? bodyLbDisabled;
  final TextStyle? bodyMr;
  final TextStyle? bodyMrHint;
  final TextStyle? bodyMm;
  final TextStyle? bodyMb;
  final TextStyle? bodySr;
  final TextStyle? bodySrPrimary;
  final TextStyle? bodySrAux;
  final TextStyle? bodySm;
  final TextStyle? bodySmDisabled;

  @override
  ThemeExtension<CustomTextTheme> copyWith({
    TextStyle? displayLr,
    TextStyle? displayMm,
    TextStyle? headingLr,
    TextStyle? bodyLr,
    TextStyle? bodyLrOnPrimary,
    TextStyle? bodyLm,
    TextStyle? bodyLmOnPrimary,
    TextStyle? bodyLb,
    TextStyle? bodyLbOnPrimary,
    TextStyle? bodyLbDisabled,
    TextStyle? bodyMr,
    TextStyle? bodyMrHint,
    TextStyle? bodyMm,
    TextStyle? bodyMb,
    TextStyle? bodySr,
    TextStyle? bodySrPrimary,
    TextStyle? bodySrAux,
    TextStyle? bodySm,
    TextStyle? bodySmDisabled,
  }) {
    return CustomTextTheme(
      displayLr: displayLr,
      displayMm: displayMm,
      headingLr: headingLr,
      bodyLr: bodyLr,
      bodyLrOnPrimary: bodyLrOnPrimary,
      bodyLm: bodyLm,
      bodyLmOnPrimary: bodyLmOnPrimary,
      bodyLb: bodyLb,
      bodyLbOnPrimary: bodyLbOnPrimary,
      bodyLbDisabled: bodyLbDisabled,
      bodyMr: bodyMr,
      bodyMrHint: bodyMrHint,
      bodyMm: bodyMm,
      bodyMb: bodyMb,
      bodySr: bodySr,
      bodySrPrimary: bodySrPrimary,
      bodySrAux: bodySrAux,
      bodySm: bodySm,
      bodySmDisabled: bodySmDisabled,
    );
  }

  @override
  ThemeExtension<CustomTextTheme> lerp(
      covariant ThemeExtension<CustomTextTheme>? other, double t) {
    if (other is! CustomTextTheme) {
      return this;
    }
    return CustomTextTheme(
      displayLr: TextStyle.lerp(displayLr, other.displayLr, t),
      displayMm: TextStyle.lerp(displayMm, other.displayMm, t),
      headingLr: TextStyle.lerp(headingLr, other.headingLr, t),
      bodyLr: TextStyle.lerp(bodyLr, other.bodyLr, t),
      bodyLrOnPrimary:
          TextStyle.lerp(bodyLrOnPrimary, other.bodyLrOnPrimary, t),
      bodyLm: TextStyle.lerp(bodyLm, other.bodyLm, t),
      bodyLmOnPrimary:
          TextStyle.lerp(bodyLmOnPrimary, other.bodyLmOnPrimary, t),
      bodyLb: TextStyle.lerp(bodyLb, other.bodyLb, t),
      bodyLbOnPrimary:
          TextStyle.lerp(bodyLbOnPrimary, other.bodyLbOnPrimary, t),
      bodyLbDisabled: TextStyle.lerp(bodyLbDisabled, other.bodyLbDisabled, t),
      bodyMr: TextStyle.lerp(bodyMr, other.bodyMr, t),
      bodyMrHint: TextStyle.lerp(bodyMrHint, other.bodyMrHint, t),
      bodyMm: TextStyle.lerp(bodyMm, other.bodyMm, t),
      bodyMb: TextStyle.lerp(bodyMb, other.bodyMb, t),
      bodySr: TextStyle.lerp(bodySr, other.bodySr, t),
      bodySrPrimary: TextStyle.lerp(bodySrPrimary, other.bodySrPrimary, t),
      bodySrAux: TextStyle.lerp(bodySrAux, other.bodySrAux, t),
      bodySm: TextStyle.lerp(bodySm, other.bodySm, t),
      bodySmDisabled: TextStyle.lerp(bodySmDisabled, other.bodySmDisabled, t),
    );
  }
}
