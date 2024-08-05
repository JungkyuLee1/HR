import 'package:get/get.dart';
import 'package:hr2024/src/controllers/bottom_nav_controller.dart';

class BottomNavBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(()=>BottomNavController(), permanent: true);
  }

}