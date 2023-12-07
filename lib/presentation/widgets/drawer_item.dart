import 'package:flutter/material.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: LayoutConstants.dimen_8,
            right: LayoutConstants.dimen_8,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .extension<CustomColorTheme>()!
                  .auxiliaryColor!
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              onTap: onTap,
              visualDensity: VisualDensity.compact,
              leading: Icon(icon),
              title: Text(
                title,
                textAlign: TextAlign.left,
                style: Theme.of(context).extension<CustomTextTheme>()!.bodyMb!,
              ),
            ),
          ),
        ),
      ],
    );

  }
}
