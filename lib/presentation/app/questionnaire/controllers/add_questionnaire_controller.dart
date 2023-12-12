import 'dart:developer';

import 'package:get/get.dart';
import 'package:onco_connect/common/constants/app_constants.dart';
import 'package:onco_connect/common/exceptions/base_app_exception.dart';
import 'package:onco_connect/common/services/custom_snackbar_service.dart';
import 'package:onco_connect/common/services/loader_service.dart';
import 'package:onco_connect/common/utils/temp_utils.dart';
import 'package:onco_connect/domain/entities/questionnaire_entity.dart';
import 'package:onco_connect/domain/repositories/questionnaire_repository.dart';

class AddQuestionnaireController extends GetxController {
  final QuestionnaireRepository repo;
  final ICustomSnackbarService snackbarService;
  final CustomLoaderService loaderService;

  Rx<bool> feedback = false.obs;
  RxList<QuestionnaireEntity?>? questions = [QuestionnaireEntity(id: 0)].obs;

  AddQuestionnaireController({
    required this.repo,
    required this.loaderService,
    required this.snackbarService,
  });

  void createNewAssessment(String question, List<String> options) async {
    try {
      loaderService.showLoader();

      feedback.value = await repo.createNewAssessment(
        photoUrl: TempUtils.imageUrl,
        question: question,
        options: options,
      );
      if (feedback.value) {
        snackbarService.showSuccessSnackbar(
          AppConstants.dataStored,
          title: AppConstants.success,
        );
      }
    } on AppException catch (e) {
      log(e.codeString, stackTrace: e.trace);
      snackbarService.showErrorSnackbar(
        e.message,
        title: e.codeString,
      );
    } finally {
      loaderService.disableLoader();
    }
  }
}
