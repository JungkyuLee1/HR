import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/components/message_popup.dart';
import 'package:hr2024/src/components/rounded_button_type_one.dart';
import 'package:hr2024/src/components/widgets/cost_input_textform.dart';
import 'package:hr2024/src/components/widgets/menu_divider.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/bottom_nav_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_addedit_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_dropdown_menu_controller.dart';
import 'package:hr2024/src/models/cost_model.dart';

class CostAddEdit extends GetView<CostAddEditController> {
  CostAddEdit({Key? key}) : super(key: key);

  CostDropDownMenuController costDropDownMenuController =
      Get.find<CostDropDownMenuController>();

  // //0.Mini Divider
  // Widget _PartDivider() {
  //   return Container(
  //     height: 3,
  //     width: 100,
  //     decoration: BoxDecoration(color: Colors.grey[200]),
  //   );
  // }

  //0.Title
  Widget Title() {
    return Center(
        child: Text(
      '항목 등록',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      textScaler: TextScaler.linear(1),
    ));
  }

  //1
  Widget PartOne() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: Get.width * 0.4,
                child: CostInputTextForm(controller.serviceNameController,
                    '서비스명', '서비스명을 입력하세요', 'serviceName',
                    icon: null)),
            SizedBox(
              width: 10,
            ),
            Container(
              width: Get.width * 0.42,
              child: Obx(
                () => DropdownButtonFormField(
                  isDense: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    return costDropDownMenuController
                        .validateServiceKind(val.toString());
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular((8)),
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                  items: costDropDownMenuController
                      .lstServiceKindsDropDownMenuItem.value,
                  value: costDropDownMenuController.selectedServiceKind.value,
                  onChanged: !AppController.to.isAdmin.value
                      ? null
                      : (selectedValue) {
                          costDropDownMenuController.selectedServiceKind.value =
                              selectedValue.toString();
                          controller.isModified.value = true;
                        },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  //2
  Widget PartTwo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width * 0.4,
              child: CostInputTextForm(
                controller.paymentDateController,
                '지급일자',
                '지급일자를 입력하세요',
                'paymentDate',
                icon: Icon(Icons.calendar_month_outlined),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: Get.width * 0.42,
              child: CostInputTextForm(
                controller.expiryDateController,
                '만료일자',
                '만료일자를 입력하세요',
                'expiryDate',
                icon: Icon(Icons.calendar_month_outlined),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  items: costDropDownMenuController
                      .lstPaymentIntervalsDropDownMenuItem.value,
                  value:
                      costDropDownMenuController.selectedPaymentInterval.value,
                  onChanged: !AppController.to.isAdmin.value
                      ? null
                      : (selectedValue) {
                          costDropDownMenuController.selectedPaymentInterval
                              .value = selectedValue.toString();
                          controller.isModified.value = true;
                        },
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: Get.width * 0.42,
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
                  items: costDropDownMenuController
                      .lstRenewMethodsDropDownMenuItem.value,
                  value: costDropDownMenuController.selectedRenewMethod.value,
                  onChanged: !AppController.to.isAdmin.value
                      ? null
                      : (selectedValue) {
                          costDropDownMenuController.selectedRenewMethod.value =
                              selectedValue.toString();
                          controller.isModified.value = true;
                        },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  //3
  Widget PartThree() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: Get.width * 0.4,
            child: CostInputTextForm(
                controller.amountController, '금액', '금액을 입력하세요', 'amount',
                icon: null)),
        SizedBox(
          width: 10,
        ),
        Container(
          width: Get.width * 0.42,
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
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  )),
              items: costDropDownMenuController
                  .lstPaymentUnitsDropDownMenuItem.value,
              value: costDropDownMenuController.selectedPaymentUnit.value,
              onChanged: !AppController.to.isAdmin.value
                  ? null
                  : (selectedValue) {
                      costDropDownMenuController.selectedPaymentUnit.value =
                          selectedValue.toString();
                      controller.isModified.value = true;
                    },
            ),
          ),
        ),
      ],
    );
  }

  //4
  Widget PartFour() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: Get.width * 0.4,
                child: CostInputTextForm(controller.paymentCardController,
                    '지급카드', '지급카드를 입력하세요', 'paymentCard',
                    icon: null)),
            SizedBox(
              width: 10,
            ),
            Container(
                width: Get.width * 0.42,
                child: CostInputTextForm(
                    controller.emailController, '이메일', '이메일을 입력하세요', 'email',
                    icon: null)),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Container(
            // width: Get.width*0.9,
            child: CostInputTextForm(
                controller.remarkController, '비고', '비고를 입력하세요', 'remark',
                icon: null)),
      ],
    );
  }

  //저장 전 model로 전환
  _assignItemToSave() {
    controller.cost(CostModel(
        id: controller.cost.value.id,
        serviceName: controller.serviceName.value,
        serviceKind: costDropDownMenuController.selectedServiceKind.value,
        paymentDate: controller.paymentDate.value,
        expiryDate: controller.expiryDate.value,
        dueDate: controller.expiryDate.value,
        paymentInterval:
            costDropDownMenuController.selectedPaymentInterval.value,
        renewMethod: costDropDownMenuController.selectedRenewMethod.value,
        amount: controller.amount.value,
        paymentUnit: costDropDownMenuController.selectedPaymentUnit.value,
        paymentCard: controller.paymentCard.value ?? '',
        email: controller.email.value ?? '',
        remark: controller.remark.value ?? '',
        activeYn: 'Y',
        createdAt: controller.addEditCostFlag.value == 'add'
            ? DateTime.now()
            : controller.cost.value.createdAt,
        createdBy: controller.addEditCostFlag.value == 'add'
            ? "creator"
            : controller.cost.value.createdBy,
        updatedAt:
            controller.addEditCostFlag.value == 'add' ? null : DateTime.now(),
        updatedBy: controller.addEditCostFlag.value == 'add' ? "" : "updater"));
  }

  //저장
  _save() async {
    controller.autoValidateMode.value = AutovalidateMode.always;

    //유효성 check
    final form = controller.formKey.currentState;
    if (form == null || !form.validate()) {
      controller.autoValidateMode.value = AutovalidateMode.disabled;
      return;
    }

    form.save();
    _assignItemToSave();
    var result;

    try {
      if (controller.addEditCostFlag.value == 'add') {
        result = await controller.saveCost();
      } else {
        result = await controller.updateCost();
      }

      if (result == 'success') {
        CustomSnackBar.showSuccessSnackBar(title: '성공', message: '저장하였습니다!');

        //저장 버튼 disable 처리
        controller.isModified.value = false;
        //저장 후 '운영비용(하단 아이콘)'->'비용조회' 화면 open
        BottomNavController.to.openCostMainPage();
      } else {
        CustomSnackBar.showErrorSnackBar(title: '실패', message: '다시 시도하십시오!');
        controller.isCostSave.value = false;
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(title: '에러', message: e.toString());
      controller.isCostSave.value = false;
    }
  }

  Widget HeaderForEdit() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                //Back 아이콘 클릭 시 '운영비용(하단 아이콘)'->'비조회' 화면 open
                BottomNavController.to.openCostMainPage();
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
              )),
          IconButton(
              onPressed: !AppController.to.isAdmin.value
                  ? null
                  : () async {
                      Get.dialog(
                          MessagePopUp('삭제', '삭제하시겠습니까?', okCallback: () async {
                        final result = await controller.deleteCostById(
                            controller.cost.value.id.toString());
                        Get.back();

                        if (result == 'deleted') {
                          CustomSnackBar.showSuccessSnackBar(
                              title: '성공', message: '삭제 완료!');

                          //저장 버튼 disable 처리
                          controller.isModified.value = false;
                          //저장 후 '운영비용(하단 아이콘)'->'비용조회' 화면 open
                          BottomNavController.to.openCostMainPage();
                        } else {
                          CustomSnackBar.showErrorSnackBar(
                              title: '실패', message: '다시 시도하십시오!');
                          controller.isCostSave.value = false;
                        }
                      }, cancelCallback: Get.back));
                    },
              icon: Icon(Icons.delete_forever))
        ],
      ),
    );
  }

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
                        child: !controller.isCostSaveLoading.value
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: Obx(
                  () => Form(
                    key: controller.formKey,
                    autovalidateMode: controller.autoValidateMode.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.addEditCostFlag.value == 'edit'
                            ? HeaderForEdit()
                            : Container(),
                        controller.addEditCostFlag.value == 'edit'
                            ? SizedBox(height: 19)
                            : Container(),
                        controller.addEditCostFlag.value == 'edit'
                            ? MenuDivider(width: Get.width)
                            : Container(),
                        controller.addEditCostFlag.value == 'edit'
                            ? SizedBox(height: 15)
                            : Container(),
                        Title(),
                        SizedBox(
                          height: 5,
                        ),
                        MenuDivider(width: Get.width * 0.22),
                        SizedBox(height: 22),
                        PartOne(),
                        SizedBox(height: 12),
                        PartTwo(),
                        SizedBox(
                          height: 12,
                        ),
                        PartThree(),
                        SizedBox(
                          height: 12,
                        ),
                        PartFour(),
                        SizedBox(
                          height: 15,
                        ),
                        SaveButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
