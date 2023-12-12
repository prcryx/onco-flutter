import 'package:flutter/material.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback? onTap;
  final String label;
  final Color? backgroundColor;
  final TextStyle? labelStyle;
  final Widget? suffixIcon;
  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundColor,
    this.labelStyle,
    this.suffixIcon,
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
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.label,
                        style: widget.labelStyle ??
                            Theme.of(context)
                                .extension<CustomTextTheme>()!
                                .bodyLrOnPrimary,
                      ),
                    ],
                  ),
                  widget.suffixIcon != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [widget.suffixIcon!],
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
