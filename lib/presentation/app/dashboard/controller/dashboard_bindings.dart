import 'package:get/get.dart';
import 'package:onco_connect/presentation/app/dashboard/controller/dashboard_controller.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());
  }
}
