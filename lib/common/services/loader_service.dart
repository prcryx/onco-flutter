import 'package:get/get.dart';

class CustomLoaderService extends GetxController{
  // CustomLoaderService();

  RxBool isLoading = false.obs;
  
  void showLoader() {
    isLoading.value = true;
  }
  void disableLoader() {
    isLoading.value = false;
  }
}
