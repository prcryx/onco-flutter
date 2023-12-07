import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';

class DefaultTextTheme {
  DefaultTextTheme._();

  static final TextStyle displayLr = GoogleFonts.playfairDisplay().copyWith(
    fontSize: LayoutConstants.dimen_32,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle displayMm = GoogleFonts.playfairDisplay().copyWith(
    fontSize: LayoutConstants.dimen_24,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle headingLr = GoogleFonts.roboto().copyWith(
    fontSize: LayoutConstants.dimen_24,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle bodyLr = GoogleFonts.roboto().copyWith(
    fontSize: LayoutConstants.dimen_16,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle bodyLm = GoogleFonts.roboto().copyWith(
    fontSize: LayoutConstants.dimen_16,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle bodyLb = GoogleFonts.roboto().copyWith(
    fontSize: LayoutConstants.dimen_16,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle bodyMr = GoogleFonts.roboto().copyWith(
    fontSize: LayoutConstants.dimen_14,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle bodyMm = GoogleFonts.roboto().copyWith(
    fontSize: LayoutConstants.dimen_14,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle bodyMb = GoogleFonts.roboto().copyWith(
    fontSize: LayoutConstants.dimen_14,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle bodySr = GoogleFonts.roboto().copyWith(
    fontSize: LayoutConstants.dimen_12,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle bodySm = GoogleFonts.roboto().copyWith(
    fontSize: LayoutConstants.dimen_12,
    fontWeight: FontWeight.w500,
  );
}
