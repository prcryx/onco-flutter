import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import 'custom_snackbar_service.dart';

abstract class IConnectivityService {
  bool get isConnected;
}

class ConnectivityService extends GetxService implements IConnectivityService {
  final ICustomSnackbarService customSnackbar;
  ConnectivityService({
    required this.customSnackbar,
  });

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  RxBool connected = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  void checkConnectivity() async {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult event) {
        switch (event) {
          case ConnectivityResult.mobile:
          case ConnectivityResult.wifi:
            if (connected.value == false) {
              connected.value = true;
              customSnackbar
                  .showSuccessSnackbar(AppConstants.connectedToInternet);
            }
            break;
          default:
            customSnackbar.showErrorSnackbar(AppConstants.noInternet);
            break;
        }
      },
    );
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  @override
  bool get isConnected {
    return connected.value;
  }
}
