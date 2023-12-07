import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/theme/app_colors.dart';

enum SnackbarType {
  success,
  failed,
  none,
}

class SnackBar {
  SnackBar(SnackbarType success);
  static void build(
    SnackbarType type,
    String message, {
    String? title,
  }) {
    Get.showSnackbar(_build(type, title: title, message));
  }

  static GetSnackBar _build(
    SnackbarType type,
    String message, {
    int? duration,
    String? title,
  }) {
    return GetSnackBar(
      titleText: title != null ? _textWidget(title, FontWeight.w600) : null,
      messageText: _textWidget(message, FontWeight.w400),
      icon: Icon(
        _getIcon(type),
        size: LayoutConstants.dimen_24,
        color: AppColor.snowDrift,
      ),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: _getBackgroundColor(type),
      borderRadius: LayoutConstants.dimen_8,
      shouldIconPulse: false,
      margin: const EdgeInsets.symmetric(
        horizontal: LayoutConstants.dimen_16,
        vertical: LayoutConstants.dimen_32,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: LayoutConstants.dimen_16,
        vertical: LayoutConstants.dimen_16,
      ),
      duration: (duration ?? 3).seconds,
      isDismissible: true,
    );
  }

  static Widget _textWidget(String text, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
        fontSize: LayoutConstants.dimen_16,
        color: AppColor.snowDrift,
        fontWeight: fontWeight,
      ),
    );
  }

  static IconData _getIcon(SnackbarType type) {
    IconData icon = Icons.info;
    switch (type) {
      case SnackbarType.success:
        icon = Icons.info;
        break;
      case SnackbarType.failed:
        icon = Icons.error_outline_rounded;
        break;
      default:
        icon = Icons.help;
        break;
    }
    return icon;
  }

  static Color _getBackgroundColor(SnackbarType type) {
    Color backgroundColor = _getColorWithOpacity(AppColor.spotlight);
    switch (type) {
      case SnackbarType.success:
        backgroundColor = _getColorWithOpacity(AppColor.spotlight);
        break;
      case SnackbarType.none:
        backgroundColor = AppColor.transparent;
        break;
      case SnackbarType.failed:
        backgroundColor = _getColorWithOpacity(AppColor.jasper);
        break;
    }
    return backgroundColor;
  }

  static Color _getColorWithOpacity(Color color) {
    return color.withOpacity(0.70);
  }
}
