import 'package:get/get.dart';
import 'package:onco_connect/common/services/custom_snackbar_service.dart';
import 'package:onco_connect/common/services/loader_service.dart';
import 'package:onco_connect/domain/repositories/questionnaire_repository.dart';
import 'package:onco_connect/presentation/app/dashboard/controller/dashboard_controller.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/home/controllers/home_controller.dart';

import '../../../../common/services/firebase_services.dart';

class DashboardBindings extends Bindings {
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
    Get.put<DashboardController>(DashboardController());
    Get.put<HomeController>(
      HomeController(
        repo: Get.find<QuestionnaireRepository>(),
        loaderService: Get.find<CustomLoaderService>(),
        snackbarService: Get.find<ICustomSnackbarService>(),
      ),
    );
  }
}
