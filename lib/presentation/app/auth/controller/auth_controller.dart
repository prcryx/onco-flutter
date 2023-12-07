import 'package:get/get.dart';
import 'package:onco_connect/common/exceptions/user_exception.dart';
import 'package:onco_connect/common/services/connectivity_service.dart';
import 'package:onco_connect/common/services/custom_snackbar_service.dart';
import 'package:onco_connect/common/services/loader_service.dart';
import 'package:onco_connect/domain/entities/user_entity.dart';
import 'package:onco_connect/domain/repositories/auth_repository.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';

abstract class IAuthController {
  void fetchUser();
  bool isEmptyUser();
  String? getUserId();
  void createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNo,
    required String username,
  });
  void loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  void signOut();
  UserEntity? getUser();
}

class AuthController extends GetxController implements IAuthController {
  final AuthRepository authRepo;
  final IConnectivityService connectivityService;
  final ICustomSnackbarService snackbarService;
  final CustomLoaderService loaderService;
  AuthController({
    required this.authRepo,
    required this.connectivityService,
    required this.snackbarService,
    required this.loaderService,
  });

  Rx<UserEntity?> user = UserEntity.empty().obs;

  @override
  void fetchUser() async {
    try {
      loaderService.showLoader();
      if (connectivityService.isConnected == true) {
        user.value = await authRepo.fetchUser();
      } else {
        snackbarService.showErrorSnackbar(
          "you are not connected to Internet",
          title: "No Internet Connection Found",
        );
      }
    } catch (e) {
      // error.value = e as Error;
      snackbarService.showErrorSnackbar(
        "Please Try again",
        title: "Server Error",
      );
    } finally {
      loaderService.disableLoader();
      update();
    }
  }

  @override
  bool isEmptyUser() {
    return user.value?.uid != null;
  }

  @override
  void createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNo,
    required String username,
  }) async {
    try {
      loaderService.showLoader();
      if (connectivityService.isConnected == true) {
        bool feedback = await authRepo.createUser(
          email: email,
          password: password,
          phoneNo: phoneNo,
          username: username,
        );
        if (feedback == true) {
          snackbarService.showSuccessSnackbar(
            "Your data is stored",
            title: "Success",
          );
          Get.offAllNamed(RouteName.dashboardScreen);
        } else {
          snackbarService.showErrorSnackbar(
            "Your Data account is not set up. Try after some time",
            title: "Failed",
          );
        }
      } else {
        snackbarService.showErrorSnackbar(
          "you are not connected to Internet",
          title: "No Internet Connection Found",
        );
      }
    } on AppException catch (e) {
      snackbarService.showErrorSnackbar(
        e.message,
        title: '${e.codeInt} ${e.codeString}',
      );
    } finally {
      loaderService.disableLoader();
    }
  }

  @override
  String? getUserId() {
    return authRepo.getUserId();
  }

  @override
  void signOut() async {
    try {
      loaderService.showLoader();
      await authRepo.signOut();
      snackbarService.showSuccessSnackbar(
        "Logged out successfully",
        title: "Success",
      );
      Get.offNamed(RouteName.splashScreen);
    } catch (e) {
      snackbarService.showErrorSnackbar(
        "Please try again",
        title: "Error Occurred",
      );
    } finally {
      loaderService.disableLoader();
    }
  }

  @override
  void loginWithEmailAndPassword(
      {required String email, required String password}) async {
    bool feedback = false;
    loaderService.showLoader();
    try {
      feedback = await authRepo.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (feedback) {
        user.value = await authRepo.fetchUser();
        snackbarService.showSuccessSnackbar(
          "You logged in successfully",
          title: "Success",
        );
        Get.offAllNamed(RouteName.dashboardScreen);
      } else {
        snackbarService.showErrorSnackbar(
          "Please provide correct password and email",
          title: "Failed",
        );
      }
    } on AppException catch (e) {
      snackbarService.showErrorSnackbar(
        "${e.codeInt}: ${e.message}",
        title: e.codeString,
      );
    } finally {
      loaderService.disableLoader();
      update();
    }
  }

  @override
  UserEntity? getUser() => user.value;
}
