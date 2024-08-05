import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/cost/cost_display_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_dropdown_menu_controller.dart';
import 'package:hr2024/src/models/cost_model.dart';
import 'package:hr2024/src/repositories/cost_repository.dart';
import 'package:intl/intl.dart';

class CostAddEditController extends GetxController {
  static CostAddEditController get to => Get.find();
  CostDisplayController costDisplayController = Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var cost = Rx<CostModel>(CostModel.initial());
  var autoValidateMode = AutovalidateMode.disabled.obs;
  var addEditCostFlag = 'add'.obs;
  var selectedDate = DateTime.now();

  //저장 버튼 on/off flag(입력항목 모두 입력되었을 때 true로 전환)
  var isCostSave = false.obs;

  //저장 버튼 클릭 후 처리중에는 CircularProgressIndicator()로 보여주기 위한 flag
  var isCostSaveLoading = false.obs;

  //Field 수정이 되어야만 저장 버튼 on처리
  var isModified = false.obs;

  var serviceName = ''.obs;
  var paymentDate = DateTime.now().obs;
  var expiryDate = DateTime.now().obs;
  var amount = '0'.obs;
  var paymentCard = ''.obs;
  var email = ''.obs;
  var remark = ''.obs;
  String errorMessage = '';

  late TextEditingController serviceNameController;
  late TextEditingController paymentDateController;
  late TextEditingController expiryDateController;
  late TextEditingController paymentCardController;
  late TextEditingController amountController;
  late TextEditingController emailController;
  late TextEditingController remarkController;

  // var serviceNameController=TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    serviceNameController = TextEditingController();
    paymentDateController = TextEditingController();
    expiryDateController = TextEditingController();
    amountController = TextEditingController();
    paymentCardController = TextEditingController();
    emailController = TextEditingController();
    remarkController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    serviceNameController.dispose();
    paymentCardController.dispose();
    expiryDateController.dispose();
    paymentCardController.dispose();
    amountController.dispose();
    emailController.dispose();
    remarkController.dispose();
  }

  //DatePicker (지급일자,만료일자 입력)
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
      if (item == 'paymentDate') {
        paymentDateController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate);
        paymentDate.value = selectedDate;
      } else if (item == 'expiryDate') {
        expiryDateController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate);
        expiryDate.value = selectedDate;
      }
    }
  }

  //입력항목 check(저장 전)
  String checkInputItem() {
    errorMessage = '';

    if (serviceName == null ||
        serviceName.isEmpty ||
        serviceName.trim().isBlank!) {
      errorMessage = '서비스명을 입력하세요';
    } else if (CostDropDownMenuController.to.selectedServiceKind.value ==
        '종류') {
      errorMessage = '종류를 입력하세요';
    } else if (paymentDateController.text == '') {
      errorMessage = '지급일자를 입력하세요';
    } else if (expiryDateController.text == '') {
      errorMessage = '만료일자를 입력하세요';
    } else if (CostDropDownMenuController
        .to.selectedPaymentInterval.value.isEmpty) {
      errorMessage = '지급주기를 입력하세요';
    } else if (CostDropDownMenuController
        .to.selectedRenewMethod.value.isEmpty) {
      errorMessage = '갱신주기를 입력하세요';
    } else if (CostDropDownMenuController
        .to.selectedPaymentUnit.value.isEmpty) {
      errorMessage = '단위를 입력하세요';
    }
    return errorMessage;
  }

  //저장 후 변수 초기화
  initializeFieldsAfterSave() {
    serviceNameController = TextEditingController();
    paymentDateController = TextEditingController();
    expiryDateController = TextEditingController();
    amountController = TextEditingController();
    paymentCardController = TextEditingController();
    emailController = TextEditingController();
    remarkController = TextEditingController();
    CostDropDownMenuController.to.selectedServiceKind.value = 'CLOUD';
    CostDropDownMenuController.to.selectedPaymentInterval.value = 'MONTHLY';
    CostDropDownMenuController.to.selectedRenewMethod.value = 'AUTO';
    CostDropDownMenuController.to.selectedPaymentUnit.value = 'USD';
  }

  //해당 운영비용 조회 시 비용정보 세팅(Edit 경우)
  setCostDataForEdit() {
    //지급일자
    String yyyyMMddPaymentDate = cost.value.paymentDate.toString();
    String convPaymentDate = yyyyMMddPaymentDate.substring(0, 10);
    //만료일자
    String yyyyMMddExpiryDate = cost.value.expiryDate.toString();
    String convExpiryDate = yyyyMMddExpiryDate.substring(0, 10);

    serviceNameController = TextEditingController(text: cost.value.serviceName);
    paymentDateController = TextEditingController(text: convPaymentDate);
    expiryDateController = TextEditingController(text: convExpiryDate);

    amountController = TextEditingController(text: cost.value.amount);
    paymentCardController = TextEditingController(text: cost.value.paymentCard);
    emailController = TextEditingController(text: cost.value.email);
    remarkController = TextEditingController(text: cost.value.remark);
    CostDropDownMenuController.to.selectedServiceKind.value =
        cost.value.serviceKind;
    CostDropDownMenuController.to.selectedPaymentInterval.value =
        cost.value.paymentInterval;
    CostDropDownMenuController.to.selectedRenewMethod.value =
        cost.value.renewMethod;
    CostDropDownMenuController.to.selectedPaymentUnit.value =
        cost.value.paymentUnit;
  }

  //운영비용 저장
  Future<String> saveCost() async {
    var result;

    try {
      isCostSave.value = true;
      isCostSaveLoading.value = true;

      result = await CostRepository.to.saveCost(cost.value);
      isCostSaveLoading.value = false;
    } catch (e) {
      isCostSave.value = false;
      isCostSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //운영비용 수정
  Future<String> updateCost() async {
    var result;

    try {
      isCostSave.value = true;
      isCostSaveLoading.value = true;

      await Future.delayed(Duration(seconds: 1));
      result = await CostRepository.to.updateCost(cost.value);
      isCostSaveLoading.value = false;
    } catch (e) {
      isCostSave.value = false;
      isCostSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //운영비용 삭제
  Future<String> deleteCostById(String id) async {
    var result;

    try {
      isCostSave.value = true;
      isCostSaveLoading.value = true;

      result = await CostRepository.to.deleteCostById(id);
      isCostSaveLoading.value = false;
    } catch (e) {
      isCostSave.value = false;
      isCostSaveLoading.value = false;
      rethrow;
    }
    return result;
  }
}
