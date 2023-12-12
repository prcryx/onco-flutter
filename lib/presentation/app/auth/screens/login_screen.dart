import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/presentation/app/auth/auth_constants.dart';
import 'package:onco_connect/presentation/app/auth/controller/auth_controller.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';
import 'package:onco_connect/presentation/widgets/app_logo.dart';
import 'package:onco_connect/presentation/widgets/custom_textfield.dart';
import 'package:onco_connect/presentation/widgets/primary_button.dart';
import 'package:onco_connect/presentation/widgets/primary_container.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late AuthController authController;

  late ValueNotifier<String> emailNotifier;
  late ValueNotifier<String> passwordNotifier;

  @override
  void initState() {
    authController = Get.find<AuthController>();
    _initializeValueNotifiers();
    super.initState();
  }

  void _initializeValueNotifiers() {
    emailNotifier = ValueNotifier("");
    passwordNotifier = ValueNotifier("");
  }

  void _loginAccount() {
    final isValidate = formKey.currentState!.validate();
    if (isValidate) {
      authController.loginWithEmailAndPassword(
        email: emailNotifier.value,
        password: passwordNotifier.value,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).extension<CustomColorTheme>()!.loginBg,
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const XLVSpacer(),
            const AppLogo(),
            const Spacer(
              flex: 2,
            ),
            _buildTitle(),
            const LVSpacer(),
            _buildForm(),
            const Spacer(
              flex: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return PrimaryContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                AuthConstants.login,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).extension<CustomTextTheme>()!.displayLr!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return PrimaryContainer(
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              hintText: AuthConstants.email,
              inputType: InputType.email,
              onChanged: (value) {
                // debugPrint(value);
                emailNotifier.value = value;
              },
            ),
            const RVSpacer(),
            CustomTextField(
              hintText: AuthConstants.password,
              inputType: InputType.password,
              onChanged: (value) {
                // debugPrint(value);
                passwordNotifier.value = value;
              },
            ),
            const LVSpacer(),
            PrimaryButton(
              label: AuthConstants.createAccount,
              onTap: _loginAccount,
            )
          ],
        ),
      ),
    );
  }
}
