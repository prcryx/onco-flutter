import 'package:get/get.dart';
import 'package:onco_connect/common/services/custom_snackbar_service.dart';
import 'package:onco_connect/common/services/firebase_services.dart';
import 'package:onco_connect/common/services/loader_service.dart';

import '../../../../domain/repositories/questionnaire_repository.dart';
import 'add_questionnaire_controller.dart';
import 'questionnaire_controller.dart';

class QuestionnaireBindings extends Bindings {
  @override
  void dependencies() {
    _repositories();
    _controllers();
  }

  void _repositories() {
    Get.put<QuestionnaireRepository>(
      QuestionnaireRepositoryImpl(
        firebaseServices: Get.find<IFirebaseServices>(),
      ),
    );
  }

  void _controllers() {
    Get.put<QuestionnaireController>(
      QuestionnaireController(
        repo: Get.find<QuestionnaireRepository>(),
        loaderService: Get.find<CustomLoaderService>(),
        snackbarService: Get.find<ICustomSnackbarService>(),
      ),
    );
    Get.put<AddQuestionnaireController>(
      AddQuestionnaireController(
        repo: Get.find<QuestionnaireRepository>(),
        loaderService: Get.find<CustomLoaderService>(),
        snackbarService: Get.find<ICustomSnackbarService>(),
      ),
    );
  }
}
