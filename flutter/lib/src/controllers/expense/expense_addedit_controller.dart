import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/models/code_model.dart';
import 'package:hr2024/src/models/expense_model.dart';
import 'package:hr2024/src/repositories/expense_repository.dart';
import 'package:intl/intl.dart';

class ExpenseAddEditController extends GetxController {
  static ExpenseAddEditController get to => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled.obs;

  late TextEditingController inOutDateController;
  late TextEditingController itemController;
  late TextEditingController amountController;
  late TextEditingController remarkController;

  //저장 버튼 on/off flag(입력항목 모두 입력되었을 때 true로 전환)
  var isExpenseSave = false.obs;

  //저장 버튼 클릭 후 처리중에는 CircularProgressIndicator()로 보여주기 위한 flag
  var isExpenseSaveLoading = false.obs;

  //Field 수정이 되어야만 저장 버튼 on처리
  var isModified = false.obs;
  var selectedDate = DateTime.now();
  var addEditExpenseFlag = 'add'.obs;

  var expense = Rx<ExpenseModel>(ExpenseModel.initial());
  RxBool selectedRadio = false.obs;
  String kind = 'IN';
  var inOutcomeDate = DateTime.now().obs;
  var item = ''.obs;
  var amount = 0.obs;
  var remark = ''.obs;

  var selectedUnitName = ''.obs;
  var codeList = <CodeModel>[];
  var units = Rx<List<CodeModel>>([]);
  var lstUnitDropDownMenuItem = Rx<List<DropdownMenuItem<String>>>([]);

  @override
  void onInit() {
    super.onInit();

    inOutDateController = TextEditingController();
    itemController = TextEditingController();
    amountController = TextEditingController();
    remarkController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    getEmpCodes();
  }

  @override
  void dispose() {
    super.dispose();
    inOutDateController.dispose();
    itemController.dispose();
    amountController.dispose();
    remarkController.dispose();
  }

  //code 조회(경비항목 정보)
  void getEmpCodes() {
    try {
      ExpenseRepository.to.getUnitCode().then((resp) {
        codeList = resp;

        getUnitDropDownData();
      });
    } catch (e) {
      rethrow;
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

  //Radio button 선택 반영
  void changeRadio(value) {
    selectedRadio.value = value;
    if (value) {
      kind = 'OUT';
    } else {
      kind = 'IN';
    }
  }

  //DatePicker (입금/출금일자 입력)
  chooseDate(String item) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
      // initialEntryMode: DatePickerEntryMode.input,
      // initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select Date',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      fieldLabelText: 'Input Date',
    );
    if (selectedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate ?? selectedDate;

      if (item == 'expenseInOutDate') {
        inOutDateController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate);
        inOutcomeDate.value = selectedDate;
      }
    }
  }

  //운영비용 저장
  Future<String> saveExpense() async {
    var result;

    try {
      isExpenseSave.value = true;
      isExpenseSaveLoading.value = true;

      result = await ExpenseRepository.to.saveExpense(expense.value);
      isExpenseSaveLoading.value = false;
    } catch (e) {
      isExpenseSave.value = false;
      isExpenseSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //운영비용 수정
  Future<String> updateExpense() async {
    var result;

    try {
      isExpenseSave.value = true;
      isExpenseSaveLoading.value = true;

      await Future.delayed(Duration(seconds: 1));
      result = await ExpenseRepository.to.updateExpense(expense.value);
      isExpenseSaveLoading.value = false;
    } catch (e) {
      isExpenseSave.value = false;
      isExpenseSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //운영비용 삭제
  Future<String> deleteExpenseById(String id) async {
    var result;

    try {
      isExpenseSave.value = true;
      isExpenseSaveLoading.value = true;

      // await Future.delayed(Duration(seconds: 1));
      result = await ExpenseRepository.to.deleteExpenseById(id);
      isExpenseSaveLoading.value = false;
    } catch (e) {
      isExpenseSave.value = false;
      isExpenseSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //저장 후 변수 초기화
  initializeFieldsAfterSave() {
    selectedRadio.value = false;
    inOutDateController = TextEditingController();
    itemController = TextEditingController();
    amountController = TextEditingController();
    remarkController = TextEditingController();
    selectedUnitName.value = 'IDR';
  }

  //해당 운영비용 조회 시 비용정보 세팅(Edit 경우)
  setExpenseDataForEdit() {
    //입출금일자
    String yyyyMMddInOutcomeDate = expense.value.inOutcomeDate.toString();
    String convInOutcomeDate = yyyyMMddInOutcomeDate.substring(0, 10);

    selectedRadio.value = expense.value.kind == 'IN' ? false : true;
    inOutDateController = TextEditingController(text: convInOutcomeDate);
    itemController = TextEditingController(text: expense.value.item);
    amountController =
        TextEditingController(text: expense.value.amount.toString());
    remarkController = TextEditingController(text: expense.value.remark);
    selectedUnitName.value = expense.value.unit;
  }
}
