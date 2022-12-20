import 'package:bdr_hospital_app/controllers/NavigationController.dart';
import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController(), permanent: true);
    Get.put(PostgresController(), permanent: true);
  }
}
