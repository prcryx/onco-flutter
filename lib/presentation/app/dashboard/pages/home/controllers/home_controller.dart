import 'dart:developer';

import 'package:get/get.dart';
import 'package:onco_connect/common/exceptions/base_app_exception.dart';
import 'package:onco_connect/common/services/custom_snackbar_service.dart';
import 'package:onco_connect/common/services/loader_service.dart';
import 'package:onco_connect/domain/entities/questionnaire_entity.dart';
import 'package:onco_connect/domain/repositories/questionnaire_repository.dart';

class HomeController extends GetxController {
  HomeController({
    required this.repo,
    // required this.connectivityService,
    required this.snackbarService,
    required this.loaderService,
  });

  final QuestionnaireRepository repo;
  final ICustomSnackbarService snackbarService;
  final CustomLoaderService loaderService;

  Rx<QuestionnaireEntity> firstQuestion = QuestionnaireEntity(id: 0).obs;

  @override
  void onReady() {
    fetchFirstAssessement();
    super.onReady();
  }

  Future<void> fetchFirstAssessement() async {
    try {
      loaderService.showLoader();
      firstQuestion.value = await repo.fetchFirstQuestion();
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
}
