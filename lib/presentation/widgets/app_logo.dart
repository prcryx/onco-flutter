import 'package:flutter/material.dart';
import 'package:onco_connect/common/constants/png_constants.dart';

import 'primary_container.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(PngConstants.appLogo),
        ],
      ),
    );
  }
}