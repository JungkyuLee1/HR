import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/message_ok_popup.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/expense/expense_main_controller.dart';
import 'package:hr2024/src/models/expense_model.dart';
import 'package:hr2024/src/pages/expense/expense_addedit_page.dart';
import 'package:hr2024/src/pages/expense/expense_display_page.dart';

class ExpenseMain extends GetView<ExpenseMainController> {
  const ExpenseMain({Key? key}) : super(key: key);

  //1-1-1-1
  Color textColor(MENUExpense menu) {
    return controller.currentMenu.value == menu ? Colors.orange : Colors.grey;
  }

  FontWeight textFontWeight(MENUExpense menu) {
    return controller.currentMenu.value == menu
        ? FontWeight.bold
        : FontWeight.normal;
  }

  //1-1-1
  oneMenu(String title, IconData icon, MENUExpense menu, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: menu == MENUExpense.CREATE && !AppController.to.isAdmin.value
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
        oneMenu('입출조회', Icons.remove_red_eye_outlined, MENUExpense.DISPLAY, () {
          controller.changeMenu(MENUExpense.DISPLAY);
        }),
        oneMenu('입출등록', Icons.add, MENUExpense.CREATE, () {
          controller.changeMenu(MENUExpense.CREATE);
        }),
      ],
    );
  }

  _menuProgressBar() {
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
        if (controller.currentMenu.value == MENUExpense.DISPLAY)
          Expanded(child: ExpenseDisplay()),
        if (controller.currentMenu.value == MENUExpense.CREATE)
          Expanded(child: ExpenseAddEdit()),
      ],
    );
  }

  //1.
  _body() {
    return SafeArea(
      child: Column(
        children: [
          TabTypeMenu(),
          _menuProgressBar(),
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
