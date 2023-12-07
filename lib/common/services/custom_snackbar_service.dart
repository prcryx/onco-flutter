import 'package:get/get.dart';
import 'package:onco_connect/presentation/widgets/snackbar.dart';

abstract class ICustomSnackbarService {
  void showSuccessSnackbar(String message, {String? title});
  void showErrorSnackbar(String message, {String? title});
  void showInfoSnackbar(String message, {String? title});
}

class CustomSnackbarService extends GetxService
    implements ICustomSnackbarService {
  @override
  void showSuccessSnackbar(String message, {String? title}) {
    SnackBar.build(
      SnackbarType.success,
      message,
      title: title,
    );
  }

  @override
  void showErrorSnackbar(String message, {String? title}) {
    SnackBar.build(
      SnackbarType.failed,
      message,
      title: title,
    );
  }

  @override
  void showInfoSnackbar(String message, {String? title}) {
    SnackBar.build(
      SnackbarType.none,
      message,
      title: title,
    );
  }
}
