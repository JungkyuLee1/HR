import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/models/cost_model.dart';

class CostMainController extends GetxController {
  static CostMainController get to=>Get.find();

  var currentMenu = MENUCost.DISPLAY.obs;
  late BuildContext conTxt;

  changeMenu(MENUCost newMenu) {
    currentMenu.value = newMenu;
  }
}

