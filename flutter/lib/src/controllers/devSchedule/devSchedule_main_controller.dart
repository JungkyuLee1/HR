import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/models/dev_schedule_model.dart';

class DevScheduleMainController extends GetxController {
  static DevScheduleMainController get to=>Get.find();

  var currentMenu = MENUDevSchedule.DISPLAY.obs;
  late BuildContext conTxt;

  changeMenu(MENUDevSchedule newMenu) {
    currentMenu.value = newMenu;
  }
}