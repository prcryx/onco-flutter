import 'package:flutter/material.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';

import 'primary_container.dart';

class PlaceHolderPage extends StatelessWidget {
  final String title;
  final String? summary;
  final IconData? icon;
  const PlaceHolderPage({
    super.key,
    required this.title,
    this.summary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).extension<CustomColorTheme>()!.scaffoldBackground,
      body: PrimaryContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: LayoutConstants.dimen_156,
              ),
            ],
            const LVSpacer(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .extension<CustomTextTheme>()!
                        .bodyLbDisabled,
                  ),
                ),
              ],
            ),
            if (summary != null) ...[
              const RVSpacer(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      summary!,
                      style: Theme.of(context)
                          .extension<CustomTextTheme>()!
                          .bodyLbDisabled,
                    ),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}
