import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/utils/country_info_utils.dart';
import 'package:onco_connect/presentation/app/auth/auth_constants.dart';
import 'package:onco_connect/presentation/app/auth/controller/auth_controller.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';
import 'package:onco_connect/presentation/widgets/app_logo.dart';
import 'package:onco_connect/presentation/widgets/custom_textfield.dart';
import 'package:onco_connect/presentation/widgets/primary_button.dart';
import 'package:onco_connect/presentation/widgets/primary_container.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  late AuthController authController;

  late ValueNotifier<String> usernameNotifier;
  late ValueNotifier<String> emailNotifier;
  late ValueNotifier<String> passwordNotifier;
  late ValueNotifier<String> phoneNotifier;

  @override
  void initState() {
    authController = Get.find<AuthController>();
    _initializeValueNotifier();
    super.initState();
  }

  void _initializeValueNotifier() {
    usernameNotifier = ValueNotifier("");
    emailNotifier = ValueNotifier("");
    passwordNotifier = ValueNotifier("");
    phoneNotifier = ValueNotifier("");
  }

  void _createAccount() {
    final isValidate = formKey.currentState!.validate();
    if (isValidate) {
      authController.createUserWithEmailAndPassword(
        email: emailNotifier.value,
        password: passwordNotifier.value,
        phoneNo: phoneNotifier.value,
        username: usernameNotifier.value,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).extension<CustomColorTheme>()!.loginBg,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const RVSpacer(),
              const AppLogo(),
              const RVSpacer(),
              // const Spacer(),
              _buildTitleAndSummary(),
              const LVSpacer(),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSummary() {
    return PrimaryContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextWidget(
            AuthConstants.signUpScreenTitle,
            style: Theme.of(context).extension<CustomTextTheme>()!.displayLr!,
          ),
          const RVSpacer(),
          _buildTextWidget(
            AuthConstants.signUpScreenSubtitle,
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

  Widget _buildForm() {
    return PrimaryContainer(
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              hintText: AuthConstants.username,
              inputType: InputType.name,
              onChanged: (value) {
                // debugPrint(value);
                usernameNotifier.value = value;
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
            const RVSpacer(),
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
              hintText: AuthConstants.phoneNo,
              inputType: InputType.phone,
              selectedCountryCode: CountryCode.ind,
              onChanged: (value) {
                // debugPrint(value);
                phoneNotifier.value = value;
              },
            ),
            const LVSpacer(),
            PrimaryButton(
              label: AuthConstants.createAccount,
              onTap: _createAccount,
            )
          ],
        ),
      ),
    );
  }
}
