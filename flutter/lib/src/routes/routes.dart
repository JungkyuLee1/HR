import 'package:get/get.dart';
import 'package:hr2024/src/app.dart';
import 'package:hr2024/src/bindings/init_binding.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_main_controller.dart';
import 'package:hr2024/src/pages/hr_master.dart';
import 'package:hr2024/src/pages/serviceLink/webview_open_page.dart';

class Routes {
  static const INITIAL = '/app';

  static final routes = [
    GetPage(name: '/app', page: () => App()),
    GetPage(
        name: '/hrMaster',
        page: () => HrMaster(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EmployeeMainController());
        })),
    GetPage(name: '/webViewOpen', page: () => WebViewOpen()),
  ];
}
