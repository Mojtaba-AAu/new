import 'package:get/get.dart';
import 'package:project101/Controller/Admin/report_controller.dart';
import 'package:project101/Controller/Admin/user_controller.dart';



class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
    Get.lazyPut(()=> ReportsController());
  }

}