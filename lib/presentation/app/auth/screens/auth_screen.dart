import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/presentation/app/auth/auth_constants.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';
import 'package:onco_connect/presentation/widgets/app_logo.dart';
import 'package:onco_connect/presentation/widgets/primary_button.dart';
import 'package:onco_connect/presentation/widgets/primary_container.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _navigateToSignUpPage() {
    Get.toNamed(RouteName.signupScreen);
  }

  void _navigateToLoginPage() {
    Get.toNamed(RouteName.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: Get.height,
        child: Container(
          decoration: BoxDecoration(
            gradient: Theme.of(context)
                .extension<CustomColorTheme>()!
                .primaryGradient,
          ),
          child: Column(children: [
            const X2LVSpacer(),
            const AppLogo(),
            const XLVSpacer(),
            _buildTitleAndSummary(),
            const Spacer(),
            _buildButtons(),
            const XLVSpacer(),
          ]),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return PrimaryContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: AuthConstants.createAccount,
            onTap: _navigateToSignUpPage,
          ),
          const RVSpacer(),
          PrimaryButton(
            label: AuthConstants.login,
            onTap: _navigateToLoginPage,
            backgroundColor: Theme.of(context)
                .extension<CustomColorTheme>()!
                .complementaryColor,
            labelStyle: Theme.of(context).extension<CustomTextTheme>()!.bodyLr,
          ),
        ],
      ),
    );
  }

  // Widget _buildIcon() {
  //   return PrimaryContainer(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Image.asset(PngConstants.appLogo),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTitleAndSummary() {
    return PrimaryContainer(
      child: Column(
        children: [
          _buildTextWidget(
            AuthConstants.authScreenTitle,
            style: Theme.of(context).extension<CustomTextTheme>()!.displayLr!,
          ),
          const LVSpacer(),
          _buildTextWidget(
            AuthConstants.authScreenSummary,
            style: Theme.of(context).extension<CustomTextTheme>()!.bodyLb!,
          ),
        ],
      ),
    );
  }

  Widget _buildTextWidget(String text, {required TextStyle style}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: style,
    );
  }
}
