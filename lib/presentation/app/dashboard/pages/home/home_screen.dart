import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/app/auth/controller/auth_controller.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/home/home_constants.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/home/widgets/questionnaire_progress_card.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';
import 'package:onco_connect/presentation/widgets/drawer_item.dart';
import 'package:onco_connect/presentation/widgets/primary_container.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../common/constants/png_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IAuthController authController;
  @override
  void initState() {
    authController = Get.find<AuthController>();
    super.initState();
  }

  void _onLogout() {
    authController.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Theme.of(context).extension<CustomColorTheme>()!.scaffoldBackground,
        drawer: _buildDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context)
              .extension<CustomColorTheme>()!
              .complementaryColor,
          title: Text(
            HomeConstants.myOncoCheck,
            style: Theme.of(context).extension<CustomTextTheme>()!.bodyLb,
          ),
          iconTheme: IconThemeData(
              color:
                  Theme.of(context).extension<CustomColorTheme>()!.cursorColor),
          centerTitle: true,
          elevation: 3,
          shadowColor: Theme.of(context)
              .extension<CustomColorTheme>()!
              .cursorColor!
              .withOpacity(0.3),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const RVSpacer(),
              _buildCancerCellIcon(),
              const RVSpacer(),
              const QuestionnaireProgressCard(
                  totalQuestions: 30, totalCompleted: 10)
            ],
          ),
        ));
  }

  Widget _buildCancerCellIcon() {
    return PrimaryContainer(
      child: Row(
        children: [
          Image.asset(
            PngConstants.cancerCell,
            width: LayoutConstants.defaultSvgSize,
            height: LayoutConstants.defaultSvgSize,
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor:
          Theme.of(context).extension<CustomColorTheme>()!.complementaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .extension<CustomColorTheme>()!
                  .auxiliaryColor!,
            ),
            child: const SizedBox(
              height: LayoutConstants.dimen_112,
            ),
          ),
          DrawerItem(
            icon: Icons.logout,
            title: HomeConstants.logout,
            onTap: _onLogout,
          )
        ],
      ),
    );
  }
}
