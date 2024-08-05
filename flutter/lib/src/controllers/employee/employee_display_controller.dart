import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/models/employee_model.dart';
import 'package:hr2024/src/repositories/employee_repository.dart';

class EmployeeDisplayController extends GetxController {
  static EmployeeDisplayController get to=>Get.find();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PageStorageBucket buckGlobal = PageStorageBucket();
  var isDataProcessing = false.obs;
  var lstEmployee = Rx<List<EmployeeModel>>([]);
  var employee = Rx<EmployeeModel>(EmployeeModel.initial());
  var salaryTotal = 0.0.obs;
  var isQueryLoading=true.obs;
  //DropdownButton(역할)
  var addEdit = 'add'.obs;

  @override
  void onReady() {
    super.onReady();
    getAllEmployee();
  }

  //전체 직원조회
  Future<void> getAllEmployee() async{
    try {
      isDataProcessing(true);

      //CircularProgressIndicator 1초간 보여주기 위함
      await Future.delayed(Duration(milliseconds: 800));
      EmployeeRepository.to.getAllEmployee().then((resp) {
        isDataProcessing(false);
        lstEmployee.value.clear();
        salaryTotal.value = 0.0;
        lstEmployee.value.addAll(resp);

        //급여 총액 계산
        for (EmployeeModel employee in lstEmployee.value) {
          salaryTotal.value += employee.salary;
        }
      }, onError: (err) {
        isDataProcessing(false);
        CustomSnackBar.showErrorSnackBar(title: '에러', message: 'Internet 접속이 불완전 합니다.\n다시 시도하여 주십시오');
        // CustomSnackBar.showErrorSnackBar(title: '에러', message: err.toString());
      });
    } catch (e) {
      isDataProcessing(false);
      CustomSnackBar.showErrorSnackBar(title: '예외', message: '서비스가 원할하지 않습니다.\n다시 시도하여 주십시오');
      // CustomSnackBar.showErrorSnackBar(title: '예외', message: e.toString());
    }
  }

  //개별 직원조회
  void getEmployeeById(String id) {
    try {
      isQueryLoading.value=true;
      EmployeeRepository.to.getEmployeeById(id).then((resp) {
        employee.value=EmployeeModel.initial();
        employee.value=resp;

        // print('EmployeeRepository1 : ${employee.value.name}');
        // print('EmployeeRepository2 : ${employee.value.role}');
        // print('EmployeeRepository3 : ${employee.value.email}');
        isQueryLoading.value=false;

      }, onError: (err) {
        CustomSnackBar.showErrorSnackBar(title: '에러', message: 'Internet 접속이 불완전 합니다.\n다시 시도하여 주십시오');
       // CustomSnackBar.showErrorSnackBar(title: '에러', message: err.toString());
        isQueryLoading.value=false;
      });
    } catch (e) {
      // isDataProcessing(false);
      isQueryLoading.value=false;
      CustomSnackBar.showErrorSnackBar(title: '예외', message: '서비스가 원할하지 않지 않습니다.\n다시 시도하여 주십시오');
      // CustomSnackBar.showErrorSnackBar(title: '예외', message: e.toString());
    }
  }
}
