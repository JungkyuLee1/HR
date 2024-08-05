import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/message_ok_popup.dart';
import 'package:hr2024/src/components/message_popup.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_main_controller.dart';
import 'package:hr2024/src/pages/employee/employee_addedit_page.dart';
import 'package:hr2024/src/pages/employee/employee_display_page.dart';
import 'package:hr2024/src/pages/employee/employee_statistics_page.dart';
import '../../models/employee_model.dart';

class EmployeeMain extends GetView<EmployeeMainController> {
  const EmployeeMain({Key? key}) : super(key: key);

  //1-1-1-1
  Color textColor(MENUEmployee menu) {
    return controller.currentMenu.value == menu ? Colors.orange : Colors.grey;
  }

  FontWeight textFontWeight(MENUEmployee menu) {
    return controller.currentMenu.value == menu
        ? FontWeight.bold
        : FontWeight.normal;
  }

  //1-1-1
  oneMenu(String title, IconData icon, MENUEmployee menu, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: menu == MENUEmployee.CREATE && !AppController.to.isAdmin.value
            ? () {
                Get.dialog(MessageOkPopup(
                  '알림',
                  '권한이 없습니다\n(No Permission!)',
                  okCallback: () {
                    Get.back();
                  },
                ));
              }
            : onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Icon(
                  icon,
                  color: textColor(menu),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 14,
                    color: textColor(menu),
                    fontWeight: textFontWeight(menu)),
              )
            ],
          ),
        ),
      ),
    );
  }

  //1-1
  TabTypeMenu() {
    return Row(
      children: [
        oneMenu('직원조회', Icons.person, MENUEmployee.DISPLAY, () {
          controller.changeMenu(MENUEmployee.DISPLAY);
        }),
        oneMenu('직원등록', Icons.app_registration_outlined, MENUEmployee.CREATE,
            () {
          controller.changeMenu(MENUEmployee.CREATE);
        }),
        oneMenu('현황', Icons.show_chart_outlined, MENUEmployee.STATISTICS, () {
          controller.changeMenu(MENUEmployee.STATISTICS);
        }),
      ],
    );
  }

  _MenuDivider() {
    return Container(
      height: 2,
      width: Get.width,
      decoration: BoxDecoration(color: Colors.grey[200]),
    );
  }

  //1-2
  MenuDetail() {
    return Column(
      children: [
        if (controller.currentMenu.value == MENUEmployee.DISPLAY)
          Expanded(child: EmployeeDisplay()),
        if (controller.currentMenu.value == MENUEmployee.CREATE)
          Expanded(child: EmployeeAddEdit()),
        if (controller.currentMenu.value == MENUEmployee.STATISTICS)
          Expanded(child: EmployeeStatistics()),
      ],
    );
  }

  //1.
  _body() {
    return SafeArea(
      child: Column(
        children: [
          TabTypeMenu(),
          _MenuDivider(),
          Expanded(child: MenuDetail())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.conTxt = context;

    return Obx(
      () => Scaffold(
        body: _body(),
      ),
    );
  }
}
