import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/bindings/init_binding.dart';

import '../../models/employee_model.dart';

class EmployeeMainController extends GetxController {
  static EmployeeMainController get to=>Get.find();

  var currentMenu = MENUEmployee.DISPLAY.obs;
  late BuildContext conTxt;

  changeMenu(MENUEmployee newMenu) {
    currentMenu.value = newMenu;
  }

  @override
  void onInit() {
    InitBinding.employeeRegisterBinding();
    //직원정보 시작할 때 '운영비용' Controller도 같이 호출
    InitBinding.costRegisterBinding();
    //직원정보 시작할 때 '경비지출' Controller도 같이 호출
    InitBinding.expenseRegisterBinding();
    //직원정보 시작할 때 '개발일정' Controller도 같이 호출
    InitBinding.devScheduleRegisterBinding();
    //직원정보 시작할 때 'ServiceLink' Controller도 같이 호출
    InitBinding.serviceLinkBinding();
    //직원정보 시작할 때 '메모' Controller도 같이 호출
    InitBinding.memoWritingBinding();
  }
}

