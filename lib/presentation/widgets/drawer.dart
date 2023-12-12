import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/app_constants.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/app/auth/controller/auth_controller.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';

import 'drawer_item.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late AuthController authController;
  @override
  void initState() {
    authController = Get.find<AuthController>();
    super.initState();
  }

  void _onLogout() {
    authController.signOut();
  }

  void _navigateToQuestionnaireScreen() {
    Get.toNamed(RouteName.addQuestionnaire);
  }

  @override
  Widget build(BuildContext context) {
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
                  .scaffoldBackground,
            ),
            child: const SizedBox(
              height: LayoutConstants.dimen_112,
            ),
          ),
          DrawerItem(
            title: AppConstants.questionnaire,
            onTap: _navigateToQuestionnaireScreen,
          ),
          DrawerItem(
            icon: Icons.logout,
            title: AppConstants.logout,
            onTap: _onLogout,
          )
        ],
      ),
    );
  }
}
