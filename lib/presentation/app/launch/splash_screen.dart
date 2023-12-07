import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/png_constants.dart';
import 'package:onco_connect/presentation/app/auth/controller/auth_controller.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;
  late IAuthController authController;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    authController = Get.find<AuthController>();
    Future.delayed(const Duration(milliseconds: 1000), () {
      Get.offAllNamed(_getNextRoute());
    });
  }

  String _getNextRoute() {
    if (user == null) {
      return RouteName.authScreen;
    } else {
      authController.fetchUser();
      if (authController.getUserId() != null) {
        return RouteName.dashboardScreen;
      } else {
        return RouteName.authScreen;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: Get.find<AuthController>(),
      builder: (IAuthController controller) {
        return Scaffold(
          backgroundColor:
              Theme.of(context).extension<CustomColorTheme>()!.loginBg,
          body: Center(
            child: Image.asset(PngConstants.appLogo),
          ),
        );
      },
    );
  }
}
