import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_addedit_controller.dart';
import 'package:hr2024/src/models/code_model.dart';
import 'package:hr2024/src/repositories/employee_repository.dart';

class EmployeeDropDownMenuController extends GetxController {
  static EmployeeDropDownMenuController get to => Get.find();
  GlobalKey<FormState> dropFormKey = GlobalKey<FormState>();

  var selectedRoleName = ''.obs;
  var selectedUnitName = ''.obs;
  var selectedMaritalName = ''.obs;
  var selectedHireTypeName = ''.obs;

  var codeList = <CodeModel>[];

  var roles = Rx<List<CodeModel>>([]);
  var units = Rx<List<CodeModel>>([]);
  var maritalStatus = Rx<List<CodeModel>>([]);
  var hireTypes = Rx<List<CodeModel>>([]);

  var lstRoleDropDownMenuItem = Rx<List<DropdownMenuItem<String>>>([]);
  var lstUnitDropDownMenuItem = Rx<List<DropdownMenuItem<String>>>([]);
  var lstMaritalStatusDropDownMenuItem = Rx<List<DropdownMenuItem<String>>>([]);
  var lstHireTypeDropDownMenuItem = Rx<List<DropdownMenuItem<String>>>([]);

  @override
  void onReady() {
    super.onReady();
    getEmpCodes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //code 조회(직원정보)
  void getEmpCodes() {
    try {
      EmployeeRepository.to.getEmpCodes().then((resp) {
        codeList = resp;

        getRoleDropDownData();
        getUnitDropDownData();
        getHireTypeDropDownData();
        getMaritalDropDownData();
      });
    } catch (e) {
      rethrow;
    }
  }

  //Role 선택
  void getRoleDropDownData() {
    try {
      if (codeList.length > 0) {
        roles.value.clear();

        EmployeeAddEditController.to.addEditFlag.value == 'add'
            ? selectedRoleName.value = 'Mobile'
            : selectedRoleName.value =
                EmployeeAddEditController.to.employee.value.role;

        roles.value.addAll(
            codeList.where((role) => role.type.contains('ROLE')).toList());

        lstRoleDropDownMenuItem.value = [];
        for (CodeModel role in roles.value) {
          lstRoleDropDownMenuItem.value.add(DropdownMenuItem(
            child: Text(
              role.name,
              style: TextStyle(
                  fontSize: 14,
                  color: AppController.to.isAdmin.value
                      ? Colors.black
                      : Colors.black),
              textScaler: TextScaler.linear(1),
            ),
            value: role.name.toString(),
          ));
        }
      }
    } catch (e) {
      Get.back();
    }
  }

  //Currency 선택
  void getUnitDropDownData() {
    try {
      if (codeList.length > 0) {
        units.value.clear();
        // selectedUnitId.value = '1';
        selectedUnitName.value = 'IDR';

        units.value.addAll(
            codeList.where((role) => role.type.contains('UNIT')).toList());

        lstUnitDropDownMenuItem.value = [];

        for (CodeModel unit in units.value) {
          lstUnitDropDownMenuItem.value.add(DropdownMenuItem(
            child: Text(
              unit.name,
              style: TextStyle(
                  fontSize: 14,
                  color: AppController.to.isAdmin.value
                      ? Colors.black
                      : Colors.black),
              textScaler: TextScaler.linear(1),
            ),
            value: unit.name.toString(),
          ));
        }
      }
    } catch (e) {
      Get.back();
    }
  }

  //HireType 선택(고용형태)
  void getHireTypeDropDownData() {
    try {
      if (codeList.length > 0) {
        hireTypes.value.clear();
        selectedHireTypeName.value = '정규직';

        hireTypes.value.addAll(
            codeList.where((hire) => hire.type.contains('CONTRACT')).toList());

        lstHireTypeDropDownMenuItem.value = [];

        for (CodeModel hireType in hireTypes.value) {
          lstHireTypeDropDownMenuItem.value.add(DropdownMenuItem(
            child: Text(
              hireType.name,
              style: TextStyle(
                  fontSize: 14,
                  color: AppController.to.isAdmin.value
                      ? Colors.black
                      : Colors.black),
              textScaler: TextScaler.linear(1),
            ),
            value: hireType.name.toString(),
          ));
        }
      }
    } catch (e) {
      Get.back();
    }
  }

  //미혼&기혼 선택
  void getMaritalDropDownData() {
    try {
      if (codeList.length > 0) {
        maritalStatus.value.clear();
        selectedMaritalName.value = '미혼';
        // selectedMaritalId.value = '1';

        maritalStatus.value.addAll(
            codeList.where((role) => role.type.contains('MARITAL')).toList());

        lstMaritalStatusDropDownMenuItem.value = [];

        for (CodeModel marital in maritalStatus.value) {
          lstMaritalStatusDropDownMenuItem.value.add(DropdownMenuItem(
            child: Text(
              marital.name,
              style: TextStyle(
                  fontSize: 14,
                  color: AppController.to.isAdmin.value
                      ? Colors.black
                      : Colors.black),
              textScaler: TextScaler.linear(1),
            ),
            value: marital.name.toString(),
          ));
        }
      }
    } catch (e) {
      Get.back();
    }
  }

  // //Old code
  // void getRoleDropDownData() {
  //   try {
  //     if (roleLst.length > 0) {
  //       roles.value.clear();
  //       selectedRoleName.value = '역할';
  //       // selectedRoleCode.value = '0';
  //
  //       List.generate(
  //           roleLst.length,
  //               (index) =>
  //               roles.value.add(CodeModel.fromJson(roleLst[index])));
  //
  //       lstRoleDropDownMenuItem.value = [];
  //       lstRoleDropDownMenuItem.value.add(DropdownMenuItem(
  //         child: Text(
  //           selectedRoleName.value,
  //           style: TextStyle(fontSize: 14),
  //         ),
  //         value: selectedRoleName.value,
  //       ),
  //       );
  //
  //       for (CodeModel role in roles.value) {
  //         lstRoleDropDownMenuItem.value.add(DropdownMenuItem(
  //           child: Text(role.name, style: TextStyle(fontSize: 14),),
  //           value: role.name.toString(),
  //         ));
  //       }
  //     }
  //   }catch(e){
  //     Get.back();
  //   }
  // }
  //
  // //Currency 선택
  // void getUnitDropDownData() {
  //   try {
  //     if (unitLst.length > 0) {
  //       units.value.clear();
  //       // selectedUnitId.value = '1';
  //       selectedUnitName.value = 'IDR';
  //       List.generate(
  //           unitLst.length,
  //               (index) =>
  //               units.value.add(CodeModel.fromJson(unitLst[index])));
  //
  //       lstUnitDropDownMenuItem.value = [];
  //
  //       for (CodeModel unit in units.value) {
  //         lstUnitDropDownMenuItem.value.add(DropdownMenuItem(
  //           child: Text(unit.name, style: TextStyle(fontSize: 14),),
  //           value: unit.name.toString(),
  //         ));
  //       }
  //     }
  //   }catch(e){
  //     Get.back();
  //   }
  // }
  //
  // //미혼&기혼 선택
  // void getMaritalDropDownData() {
  //   try {
  //     if (maritalLst.length > 0) {
  //       maritalStatus.value.clear();
  //       selectedMaritalName.value = '미혼';
  //       // selectedMaritalId.value = '1';
  //       List.generate(
  //           maritalLst.length,
  //               (index) =>
  //               maritalStatus.value.add(CodeModel.fromJson(maritalLst[index])));
  //
  //       lstMaritalStatusDropDownMenuItem.value = [];
  //
  //       for (CodeModel marital in maritalStatus.value) {
  //         lstMaritalStatusDropDownMenuItem.value.add(DropdownMenuItem(
  //           child: Text(marital.name, style: TextStyle(fontSize: 14),),
  //           value: marital.name.toString(),
  //         ));
  //       }
  //     }
  //   }catch(e){
  //     Get.back();
  //   }
  // }

  String? validateRole(String value) {
    if (value == '0' || value == '역할') {
      return "역할을 선택하세요";
    }
  }
}
