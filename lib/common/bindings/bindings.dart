import 'package:get/get.dart';
import 'package:onco_connect/common/services/connectivity_service.dart';
import 'package:onco_connect/common/services/custom_snackbar_service.dart';
import 'package:onco_connect/common/services/firebase_services.dart';
import 'package:onco_connect/common/services/loader_service.dart';
import 'package:onco_connect/domain/repositories/auth_repository.dart';
import 'package:onco_connect/presentation/app/auth/controller/auth_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    _services();
    _repositories();
    _controllers();
  }

  // ====== Services ======
  void _services() {
    Get.put<IFirebaseServices>(FirebaseServices(), permanent: true);
    Get.put<ICustomSnackbarService>(CustomSnackbarService(), permanent: true);
    Get.put<IConnectivityService>(
      ConnectivityService(customSnackbar: Get.find<ICustomSnackbarService>()),
      permanent: true,
    );
    Get.put<CustomLoaderService>(CustomLoaderService(), permanent: true);
  }

  // ====== Repositories ======
  void _repositories() {
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        firebaseServices: Get.find<IFirebaseServices>(),
      ),
      permanent: true,
    );
  }

  // ====== Controllers ======
  void _controllers() {
    Get.put<AuthController>(
      AuthController(
        authRepo: Get.find<AuthRepository>(),
        // connectivityService: Get.find<IConnectivityService>(),
        snackbarService: Get.find<ICustomSnackbarService>(),
        loaderService: Get.find<CustomLoaderService>(),
      ),
      permanent: true,
    );
  }
}
