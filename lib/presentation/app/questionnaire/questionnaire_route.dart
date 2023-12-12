import 'package:get/get.dart';
import 'package:onco_connect/presentation/app/questionnaire/controllers/questionnaire_bindings.dart';
import 'package:onco_connect/presentation/app/questionnaire/add_questionnaire_screen.dart';
import 'package:onco_connect/presentation/app/questionnaire/end_page.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';

import 'questionnaire_response_screen.dart';

class QuestionnaireRoute {
  const QuestionnaireRoute._();
  static List<GetPage> getAll() {
    return [
      GetPage(
        name: RouteName.addQuestionnaire,
        page: () => const AddQuestionnaireScreen(),
        transitionDuration: 250.milliseconds,
        transition: Transition.fade,
        binding: QuestionnaireBindings(),
      ),
      GetPage(
        name: RouteName.questionnaireResponseScreen,
        page: () => const QuestionnaireResponseScreen(),
        transitionDuration: 250.milliseconds,
        transition: Transition.fade,
        binding: QuestionnaireBindings(),
      ),
      GetPage(
        name: RouteName.completed,
        page: () => const EndScreen(),
        transitionDuration: 450.milliseconds,
        transition: Transition.fade,
      ),
    ];
  }
}
