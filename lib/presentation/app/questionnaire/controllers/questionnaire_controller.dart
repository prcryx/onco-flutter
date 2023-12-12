import 'dart:developer';

import 'package:get/get.dart';
import 'package:onco_connect/common/constants/app_constants.dart';
import 'package:onco_connect/common/exceptions/base_app_exception.dart';
import 'package:onco_connect/common/utils/temp_utils.dart';
import 'package:onco_connect/domain/entities/questionnaire_entity.dart';
import 'package:onco_connect/domain/repositories/questionnaire_repository.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';
import '../../../../common/services/custom_snackbar_service.dart';
import '../../../../common/services/loader_service.dart';
import '../../../../domain/entities/user_questionnaire_response.dart';

class QuestionnaireController extends GetxController {
  final QuestionnaireRepository repo;
  final ICustomSnackbarService snackbarService;
  final CustomLoaderService loaderService;

  Rx<int> progressNotifier = 0.obs;

  Rx<bool> feedback = false.obs;
  RxList<QuestionnaireEntity?>? questions = [QuestionnaireEntity(id: 0)].obs;

  QuestionnaireController({
    required this.repo,
    required this.loaderService,
    required this.snackbarService,
  });

  @override
  void onReady() {
    fetchQuestionnaire();
    super.onReady();
  }

  // @override
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

  void fetchQuestionnaire() async {
    try {
      loaderService.showLoader();
      questions?.value = await repo.fetchQuestionnaire();
    } on AppException catch (e) {
      log(e.message, time: DateTime.now(), stackTrace: e.trace);
      snackbarService.showErrorSnackbar(
        e.message,
        title: e.codeString,
      );
    } finally {
      loaderService.disableLoader();
      update();
    }
  }

  void submit(String option, QuestionnaireEntity? entity) async {
    try {
      var resp = UserQuestionnaireResponse(
        question: entity?.question,
        questionId: entity?.id,
        response: option,
        userId: repo.getUserId(),
      );
      loaderService.showLoader();
      await repo.submitUserResponse(resp);
      progressIncrement();
      if (progressNotifier.value == questions?.length) {
        Get.offAndToNamed(RouteName.completed);
      }
    } on AppException catch (e) {
      log(e.message, time: DateTime.now(), stackTrace: e.trace);
      snackbarService.showErrorSnackbar(
        e.message,
        title: e.codeString,
      );
    } finally {
      loaderService.disableLoader();
      update();
    }
  }

  bool get isCreated => feedback.value;

  void progressIncrement() {
    progressNotifier.value++;
  }
}
