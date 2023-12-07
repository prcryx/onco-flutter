import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/common/services/loader_service.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';

class LoaderWidget extends StatelessWidget {
  final Widget child;
  const LoaderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    CustomLoaderService controller = Get.find<CustomLoaderService>();
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Obx(() => _buildContent(
              context,
              controller.isLoading.value,
            )),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    bool loading,
  ) {
    return Visibility(
      visible: loading,
      child: SizedBox(
        width: LayoutConstants.dimen_156,
        height: LayoutConstants.dimen_156,
        child: Transform.scale(
          scale: 0.5,
          child: CircularProgressIndicator(
            color:
                Theme.of(context).extension<CustomColorTheme>()!.primaryColor,
            strokeWidth: 10.0,
          ),
        ),
      ),
    );
  }
}
