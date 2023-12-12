import 'package:flutter/material.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final TextStyle? style;
  const CustomAppBar({
    super.key,
    this.title,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          Theme.of(context).extension<CustomColorTheme>()!.complementaryColor,
      title: title != null
          ? Text(
              title!,
              style: style ??
                  Theme.of(context).extension<CustomTextTheme>()!.bodyLb,
            )
          : null,
      iconTheme: IconThemeData(
          color: Theme.of(context).extension<CustomColorTheme>()!.cursorColor),
      centerTitle: true,
      elevation: 3,
      shadowColor: Theme.of(context)
          .extension<CustomColorTheme>()!
          .cursorColor!
          .withOpacity(0.3),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(LayoutConstants.dimen_56);
}
