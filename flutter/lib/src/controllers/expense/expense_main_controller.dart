import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/models/expense_model.dart';

class ExpenseMainController extends GetxController {
  static ExpenseMainController get to=>Get.find();

  var currentMenu = MENUExpense.DISPLAY.obs;
  late BuildContext conTxt;

  changeMenu(MENUExpense newMenu) {
    currentMenu.value = newMenu;
  }
}

