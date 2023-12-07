import 'package:flutter/material.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback? onTap;
  final String label;
  final Color? backgroundColor;
  final TextStyle? labelStyle;
  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundColor,
    this.labelStyle,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  void printMe() {
    debugPrint("PrimaryButton");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ?? printMe,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: LayoutConstants.dimen_16,
                vertical: LayoutConstants.dimen_16,
              ),
              decoration: ShapeDecoration(
                color: widget.backgroundColor ??
                    Theme.of(context)
                        .extension<CustomColorTheme>()!
                        .primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(LayoutConstants.dimen_112),
                ),
              ),
              child: Center(
                child: Text(
                  widget.label,
                  style: widget.labelStyle ??
                      Theme.of(context)
                          .extension<CustomTextTheme>()!
                          .bodyLrOnPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
