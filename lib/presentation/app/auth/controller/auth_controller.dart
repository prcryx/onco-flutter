import 'dart:developer';

import 'package:get/get.dart';
import 'package:onco_connect/common/constants/app_constants.dart';
import 'package:onco_connect/common/exceptions/base_app_exception.dart';
import 'package:onco_connect/common/exceptions/data_exception.dart';
import 'package:onco_connect/common/services/custom_snackbar_service.dart';
import 'package:onco_connect/common/services/loader_service.dart';
import 'package:onco_connect/common/utils/ttl_utils.dart';
import 'package:onco_connect/domain/entities/meta/meta_doc.dart';
import 'package:onco_connect/domain/entities/user_entity.dart';
import 'package:onco_connect/domain/repositories/auth_repository.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';

class AuthController extends GetxController {
  final AuthRepository authRepo;
  final ICustomSnackbarService snackbarService;
  final CustomLoaderService loaderService;
  AuthController({
    required this.authRepo,
    required this.snackbarService,
    required this.loaderService,
  });

  Rx<UserEntity?> user = UserEntity.empty().obs;
  Rx<MetaDoc> metaData = MetaDoc.init.obs;
  Rx<UserMetaDoc> userMetaData = UserMetaDoc.initWithConstant().obs;
  Rx<DateTime> prevRefresh = DateTime(2000).obs;

  void fetchUser() async {
    try {
      loaderService.showLoader();
      user.value = await authRepo.fetchUser();
    } on AppException catch (e) {
      snackbarService.showErrorSnackbar(
        e.message,
        title: e.codeString,
      );
    } finally {
      loaderService.disableLoader();
      update();
    }
  }

  void loadMetaData() async {
    try {
      loaderService.showLoader();
      DateTime now = DateTime.now();
      if (now.difference(prevRefresh.value) > TTLUtils.refreshDelayTTL) {
        metaData.value = await authRepo.getMetaData();
        userMetaData.value = await authRepo.getUserMetaData();
        prevRefresh.value = now;
      }
    } on AppException catch (e) {
      if (e is NoAppMetaDataException) {
        log(e.message, time: DateTime.now());
      } else if (e is NoUserMetaDataException) {
        userMetaData.value = UserMetaDoc.initWithConstant();
      } else {
        snackbarService.showErrorSnackbar(
          e.message,
          title: e.codeString,
        );
      }

      // error.value = e as Error;
    } finally {
      loaderService.disableLoader();
      update();
    }
  }

  // @override
  bool isEmptyUser() {
    return user.value?.uid != null;
  }

  // @override
  void createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNo,
    required String username,
  }) async {
    try {
      loaderService.showLoader();
      bool feedback = await authRepo.createUser(
        email: email,
        password: password,
        phoneNo: phoneNo,
        username: username,
      );
      if (feedback == true) {
        snackbarService.showSuccessSnackbar(
          AppConstants.dataStored,
          title: AppConstants.success,
        );
        Get.offAllNamed(RouteName.dashboardScreen);
      } else {
        snackbarService.showErrorSnackbar(
          AppConstants.accountSetUpFailed,
          title: AppConstants.failed,
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

  // @override
  String? getUserId() {
    return authRepo.getUserId();
  }

  // @override
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

  // @override
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
}
