import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/presentation/app/questionnaire/controllers/questionnaire_controller.dart';
import 'package:onco_connect/presentation/app/questionnaire/questionnaire_constants.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/widgets/custom_appbar.dart';
import 'package:onco_connect/presentation/widgets/primary_button.dart';
import 'package:onco_connect/presentation/widgets/primary_container.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';
import '../../theme/text_theme/custom_text_theme.dart';
import '../../widgets/custom_textfield.dart';

class AddQuestionnaireScreen extends StatefulWidget {
  const AddQuestionnaireScreen({super.key});

  @override
  State<AddQuestionnaireScreen> createState() => _AddQuestionnaireScreenState();
}

class _AddQuestionnaireScreenState extends State<AddQuestionnaireScreen> {
  late QuestionnaireController questionnaireController;
  final formKey = GlobalKey<FormState>();

  late ValueNotifier<String> questionNotifier;
  late ValueNotifier<String> option1Notifier;
  late ValueNotifier<String> option2Notifier;

  @override
  void initState() {
    questionnaireController = Get.find<QuestionnaireController>();
    _initializeValueNotifiers();

    super.initState();
  }

  void _initializeValueNotifiers() {
    questionNotifier = ValueNotifier("");
    option1Notifier = ValueNotifier("");
    option2Notifier = ValueNotifier("");
  }

  void _createNewQuestion() {
    questionnaireController.createNewAssessment(
      questionNotifier.value,
      [
        option1Notifier.value,
        option2Notifier.value,
      ],
    );
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).extension<CustomColorTheme>()!.loginBg,
      appBar: const CustomAppBar(),
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LVSpacer(),
            _buildTitle(),
            const Spacer(
              flex: 2,
            ),
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
                QuestionnaireConstants.createQuestion,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).extension<CustomTextTheme>()!.headingLr!,
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
              hintText: QuestionnaireConstants.question,
              inputType: InputType.name,
              onChanged: (value) {
                // debugPrint(value);
                questionNotifier.value = value;
              },
            ),
            const RVSpacer(),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: QuestionnaireConstants.option1,
                    inputType: InputType.name,
                    onChanged: (value) {
                      // debugPrint(value);
                      option1Notifier.value = value;
                    },
                  ),
                ),
                const RHSpacer(),
                Expanded(
                  child: CustomTextField(
                    hintText: QuestionnaireConstants.option2,
                    inputType: InputType.name,
                    onChanged: (value) {
                      // debugPrint(value);
                      option2Notifier.value = value;
                    },
                  ),
                )
              ],
            ),
            const XLVSpacer(),
            PrimaryButton(
              label: QuestionnaireConstants.create,
              onTap: _createNewQuestion,
            )
          ],
        ),
      ),
    );
  }
}
