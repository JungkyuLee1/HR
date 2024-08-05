import 'package:flutter/material.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/components/message_popup.dart';
import 'package:hr2024/src/components/rounded_button_type_one.dart';
import 'package:hr2024/src/components/widgets/expense_input_textform.dart';
import 'package:hr2024/src/components/widgets/menu_divider.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/bottom_nav_controller.dart';
import 'package:hr2024/src/controllers/expense/expense_addedit_controller.dart';
import 'package:hr2024/src/models/expense_model.dart';

class ExpenseAddEdit extends GetView<ExpenseAddEditController> {
  const ExpenseAddEdit({Key? key}) : super(key: key);

  //0.Edit 일 경우 '항목정보' Header 보여줌
  Widget HeaderForEdit() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                //Back 아이콘 클릭 시 '운영비용(하단 아이콘)'->'비조회' 화면 open
                BottomNavController.to.openExpenseMainPage();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 22,
              )),
          Expanded(
            flex: 4,
            child: Text(
              '항목 정보',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              textScaler: TextScaler.linear(1),
            ),
          ),
          controller.addEditExpenseFlag.value == 'add'
              ? Spacer(flex: 1)
              : IconButton(
                  onPressed: !AppController.to.isAdmin.value
                      ? null
                      : () async {
                          Get.dialog(MessagePopUp('삭제', '삭제하시겠습니까?',
                              okCallback: () async {
                            final result = await controller.deleteExpenseById(
                                controller.expense.value.id.toString());
                            Get.back();

                            if (result == 'deleted') {
                              CustomSnackBar.showSuccessSnackBar(
                                  title: '성공', message: '삭제 완료!');

                              //저장 버튼 disable 처리
                              controller.isModified.value = false;
                              //저장 후 '경비지출(하단 아이콘)'->'비용조회' 화면 open
                              BottomNavController.to.openExpenseMainPage();
                            } else {
                              CustomSnackBar.showErrorSnackBar(
                                  title: '실패', message: '다시 시도하십시오!');
                              controller.isExpenseSave.value = false;
                            }
                          }, cancelCallback: Get.back));
                        },
                  icon: Icon(Icons.delete_forever))
        ],
      ),
    );
  }

  //1.Title
  Widget Title() {
    return Padding(
      padding: const EdgeInsets.only(top: 13, bottom: 6),
      child: Center(
          child: Text(
        '입출금 등록',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textScaler: TextScaler.linear(1),
      )),
    );
  }

  //2.
  Widget RadioButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '구분',
          textScaler: TextScaler.linear(1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
                value: false,
                groupValue: controller.selectedRadio.value,
                onChanged: controller.addEditExpenseFlag.value == 'edit'
                    ? null
                    : (val) {
                        controller.changeRadio(val);
                      }),
            Text(
              '입금(IN)',
              textScaler: TextScaler.linear(1),
            ),
            SizedBox(
              width: 20,
            ),
            Radio(
                value: true,
                groupValue: controller.selectedRadio.value,
                onChanged: controller.addEditExpenseFlag.value == 'edit'
                    ? null
                    : (val) {
                        controller.changeRadio(val);
                      }),
            Text(
              '출금(OUT)',
              textScaler: TextScaler.linear(1),
            )
          ],
        ),
      ],
    );
  }

  //3.
  Widget Items() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width * 0.43,
          child: ExpenseInputTextForm(
            controller.inOutDateController,
            '입금/출금일자(Date)',
            '입금/출금일자를 입력하세요',
            'expenseInOutDate',
            icon: Icon(Icons.calendar_month_outlined),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
            // width: Get.width*0.9,
            child: ExpenseInputTextForm(
                controller.itemController, '항목(Item)', '항목을 입력하세요', 'item',
                icon: null)),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                  // width: Get.width*0.9,
                  child: ExpenseInputTextForm(
                      controller.amountController, '금액(Amount)', '금액을 입력하세요', 'amount',
                      icon: null)),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: Get.width * 0.4,
              child: Obx(
                () => DropdownButtonFormField(
                  isDense: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {},
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular((8)),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      )),
                  items: controller.lstUnitDropDownMenuItem.value,
                  value: controller.selectedUnitName.value,
                  onChanged: !AppController.to.isAdmin.value
                      ? null
                      : (selectedValue) {
                          controller.selectedUnitName.value =
                              selectedValue.toString();
                          controller.isModified.value = true;
                        },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
            // width: Get.width*0.9,
            child: ExpenseInputTextForm(
                controller.remarkController, '비고(Remark)', '비고를 입력하세요', 'remark',
                icon: null)),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  //4.
  Widget SaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        child: Stack(
          children: [
            RoundedButtonTypeOne(
              width: Get.width,
              onTap: controller.isModified.value ? _save : () {},
              buttonText: '저장',
              icon: null,
              isModified: controller.isModified.value,
            ),
            Positioned(
                height: 25,
                right: 0,
                left: 0,
                bottom: 8,
                child: Center(
                    child: Container(
                        height: 30,
                        width: 30,
                        child: !controller.isExpenseSaveLoading.value
                            ? Container()
                            : Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))))),
          ],
        ),
      ),
    );
  }

  //4-1-1 저장 전 model로 전환
  _assignItemToSave() {
    controller.expense(ExpenseModel(
        id: controller.expense.value.id,
        kind: controller.addEditExpenseFlag.value == 'add'
            ? controller.kind
            : controller.expense.value.kind,
        inOutcomeDate: controller.inOutcomeDate.value,
        item: controller.item.value,
        amount: controller.amount.value,
        unit: controller.selectedUnitName.value,
        remark: controller.remark.value ?? '',
        activeYn: 'Y',
        createdAt: controller.addEditExpenseFlag.value == 'add'
            ? DateTime.now()
            : controller.expense.value.createdAt,
        createdBy: controller.addEditExpenseFlag.value == 'add'
            ? "creator"
            : controller.expense.value.createdBy,
        updatedAt: controller.addEditExpenseFlag.value == 'add'
            ? null
            : DateTime.now(),
        updatedBy:
            controller.addEditExpenseFlag.value == 'add' ? "" : "updater"));
  }

  //4-1
  //저장
  _save() async {
    controller.autoValidateMode.value = AutovalidateMode.always;
    // //유효성 check
    final form = controller.formKey.currentState;
    if (form == null || !form.validate()) {
      controller.autoValidateMode.value = AutovalidateMode.disabled;
      return;
    }

    form.save();
    _assignItemToSave();
    var result;

    try {
      if (controller.addEditExpenseFlag.value == 'add') {
        result = await controller.saveExpense();
      } else {
        result = await controller.updateExpense();
      }

      if (result == 'success') {
        CustomSnackBar.showSuccessSnackBar(
            title: '성공',
            message: controller.addEditExpenseFlag.value == 'add'
                ? '저장 완료!'
                : '수정 완료!');

        //저장 버튼 disable 처리
        controller.isModified.value = false;
        //저장 후 '운영비용(하단 아이콘)'->'비용조회' 화면 open
        BottomNavController.to.openExpenseMainPage();
      } else {
        CustomSnackBar.showErrorSnackBar(title: '실패', message: '다시 시도하십시오!');
        controller.isExpenseSave.value = false;
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(title: '에러', message: e.toString());
      controller.isExpenseSave.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    autovalidateMode: controller.autoValidateMode.value,
                    child: Column(
                      children: [
                        controller.addEditExpenseFlag.value == 'edit'
                            ? SizedBox(height: 19)
                            : Container(),
                        controller.addEditExpenseFlag.value == 'edit'
                            ? HeaderForEdit()
                            : Container(),
                        controller.addEditExpenseFlag.value == 'edit'
                            ? SizedBox(height: 19)
                            : Container(),
                        controller.addEditExpenseFlag.value == 'edit'
                            ? MenuDivider(width: Get.width)
                            : Container(),
                        controller.addEditExpenseFlag.value == 'edit'
                            ? SizedBox(height: 1)
                            : Container(),
                        Title(),
                        MenuDivider(width: Get.width * 0.26),
                        SizedBox(
                          height: 18,
                        ),
                        RadioButton(),
                        SizedBox(
                          height: 10,
                        ),
                        Items(),
                        SaveButton(),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
