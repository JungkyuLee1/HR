import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/api/api.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/components/message_popup.dart';
import 'package:hr2024/src/components/widgets/menu_divider.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/bottom_nav_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_addedit_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_dropdownmenu_controller.dart';
import 'package:hr2024/src/models/employee_model.dart';
import '../../components/rounded_button_type_one.dart';
import '../../components/widgets/employee_input_textForm.dart';

class EmployeeAddEdit extends GetView<EmployeeAddEditController> {
  EmployeeAddEdit({Key? key}) : super(key: key);

  EmployeeDropDownMenuController employeeDropDownController =
      Get.find<EmployeeDropDownMenuController>();

  Widget PhotoPart() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 21,
        right: 20,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: !AppController.to.isAdmin.value
                ? null
                : () {
                    controller.getImage();
                    controller.isModified.value = true;
                  },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Obx(
                () => Container(
                  // padding: EdgeInsets.only(bottom: 1),
                  height: Get.height * 0.16,
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: controller.addEditFlag.value == 'add'
                      ? controller.selectedImage.value != null
                          ? Image.file(
                              controller.selectedImage.value!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/person.jpeg',
                              fit: BoxFit.cover,
                            )
                      : controller.selectedImage.value != null
                          ? Image.file(controller.selectedImage.value!,
                              fit: BoxFit.cover)
                          : controller.imageUrl.trim() == ''
                              ? Image.asset(
                                  'assets/images/person.jpeg',
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: Api.baseUrl +
                                      '/getProfileImage?fileName=${controller.imageUrl}',
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Container(
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                        color: Colors.black26,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                ),
              ),

              // child: Obx(
              //       () => Container(
              //     // padding: EdgeInsets.only(bottom: 1),
              //       height: Get.height * 0.16,
              //       width: Get.width * 0.3,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       child: controller.selectedImage.value != null
              //           ? Image.file(
              //         controller.selectedImage.value!,
              //         fit: BoxFit.cover,
              //       )
              //           : Image.asset(
              //         'assets/images/person.jpeg',
              //         fit: BoxFit.cover,
              //       )),
              // ),
            ),
          ),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  child: EmployeeInputTextForm(
                      controller.nameController, '성명', '성명을 입력하세요', 'name',
                      icon: null),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => DropdownButtonFormField(
                    isDense: true,
                    autovalidateMode: AutovalidateMode.disabled,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) {
                      return employeeDropDownController
                          .validateRole(val.toString());
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular((8)),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                        )),
                    items: employeeDropDownController
                        .lstRoleDropDownMenuItem.value,
                    value: controller.addEditFlag.value == 'add'
                        ? employeeDropDownController.selectedRoleName.value
                        : controller.employee.value.role,
                    onChanged: !AppController.to.isAdmin.value
                        ? null
                        : (selectedValue) {
                            employeeDropDownController.selectedRoleName.value =
                                selectedValue.toString();
                            controller.isModified.value = true;
                          },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget InputBodyOne() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width * 0.37,
                child: EmployeeInputTextForm(
                  controller.entryDateController,
                  '입사일자',
                  '입사일자를 입력하세요',
                  'entryDate',
                  icon: Icon(Icons.calendar_month_outlined),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: Get.width * 0.4,
                child: EmployeeInputTextForm(
                  controller.careerController,
                  '경력(년)',
                  '경력(년)을 입력하세요',
                  'career',
                  icon: null,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width * 0.3,
                    child: EmployeeInputTextForm(
                      controller.salaryController,
                      '급여',
                      '급여를 입력하세요',
                      'salary',
                      icon: null,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: Get.width * 0.25,
                    child: Obx(
                      () => DropdownButtonFormField(
                        isDense: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {},
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular((8)),
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            )),
                        items: employeeDropDownController
                            .lstUnitDropDownMenuItem.value,
                        value:
                            employeeDropDownController.selectedUnitName.value,
                        onChanged: !AppController.to.isAdmin.value
                            ? null
                            : (selectedValue) {
                                employeeDropDownController.selectedUnitName
                                    .value = selectedValue.toString();
                                controller.isModified.value = true;
                              },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: Get.width * 0.3,
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
                    items: employeeDropDownController
                        .lstHireTypeDropDownMenuItem.value,
                    value:
                        employeeDropDownController.selectedHireTypeName.value,
                    onChanged: !AppController.to.isAdmin.value
                        ? null
                        : (selectedValue) {
                            employeeDropDownController.selectedHireTypeName
                                .value = selectedValue.toString();
                            controller.isModified.value = true;
                          },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget InputBodyTwo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 13),
      child: Column(
        children: [
          EmployeeInputTextForm(
            controller.skillController,
            '보유기술',
            '보유기술을 입력하세요',
            'skill',
            icon: null,
          ),
          SizedBox(
            height: 10,
          ),
          EmployeeInputTextForm(
              controller.hpController, '핸드폰', '핸드폰 No.를 입력하세요', 'hp',
              icon: Icon(Icons.phone)),
        ],
      ),
    );
  }

  Widget InputBodyThree() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
      child: Column(
        children: [
          EmployeeInputTextForm(
              controller.emailController, 'email', 'Email을 입력하세요', 'email',
              icon: Icon(Icons.email_outlined)),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: Get.width * 0.37,
                  child: EmployeeInputTextForm(controller.birthDateController,
                      '생년월일', '생년월일을 입력하세요', 'birthDate',
                      icon: Icon(Icons.calendar_month_outlined))),
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
                    items: employeeDropDownController
                        .lstMaritalStatusDropDownMenuItem.value,
                    value: employeeDropDownController.selectedMaritalName.value,
                    onChanged: !AppController.to.isAdmin.value
                        ? null
                        : (selectedValue) {
                            employeeDropDownController.selectedMaritalName
                                .value = selectedValue.toString();
                            controller.isModified.value = true;
                          },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          EmployeeInputTextForm(
              controller.familyController, '가족사항', '가족사항을 입력하세요', 'family',
              icon: null),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: Get.width * 0.4,
                  child: EmployeeInputTextForm(
                      controller.bankController, '은행명', '은행명을 입력하세요', 'bank',
                      icon: null)),
              Container(
                  width: Get.width * 0.4,
                  child: EmployeeInputTextForm(controller.bankAccountController,
                      '계좌번호', '계좌번호를 입력하세요', 'bankAccount',
                      icon: null)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          EmployeeInputTextForm(
              controller.remarkController, '비고', '비고를 입력하세요', 'remark',
              icon: null),
        ],
      ),
    );
  }

  //중간 구분선
  _PartDivider() {
    return Container(
      height: 2,
      width: Get.width * 0.8,
      decoration: BoxDecoration(color: Colors.grey[200]),
    );
  }

  //최상단 구분선
  // _MenuDivider() {
  //   return Container(
  //     height: 2,
  //     width: Get.width,
  //     decoration: BoxDecoration(color: Colors.grey[200]),
  //   );
  // }

  //저장 전 model로 전환
  _assignItemsToSave() async {
    // print('role : ${employeeDropDownController.selectedRoleName.value}');

    await controller.employee(EmployeeModel(
        id: controller.employee.value.id ?? "0",
        name: controller.name.value,
        imageUrl: controller.addEditFlag.value == 'add'
            ? 'imageUrlink'
            : controller.imageUrl.value,
        role: employeeDropDownController.selectedRoleName.value,
        entryDate: controller.entryDate.value,
        hireType: employeeDropDownController.selectedHireTypeName.value,
        career: controller.career.value,
        salary: controller.salary.value,
        unit: employeeDropDownController.selectedUnitName.value,
        skill: controller.skill.value,
        hp: controller.hp.value,
        email: controller.email.value,
        birthDate: controller.birthDate.value,
        marital: employeeDropDownController.selectedMaritalName.value,
        family: controller.family.value,
        bank: controller.bank.value,
        bankAccount: controller.bankAccount.value,
        remark: controller.remark.value,
        activeYn: 'Y',
        createdAt: controller.addEditFlag.value == 'add'
            ? DateTime.now()
            : controller.employee.value.createdAt,
        createdBy: controller.addEditFlag.value == 'add'
            ? "creator"
            : controller.employee.value.createdBy,
        updatedAt:
            controller.addEditFlag.value == 'add' ? null : DateTime.now(),
        updatedBy: controller.addEditFlag.value == 'add' ? "" : "updater"));
  }

  //저장
  _save() async {
    controller.autoValidateMode.value = AutovalidateMode.always;

    //2nd page 유효성 check
    final form = controller.formKey.currentState;
    if (form == null || !form.validate()) {
      controller.autoValidateMode.value = AutovalidateMode.disabled;
      return;
    }

    // //입력항목 check(저장 전)
    // if (controller.checkInputItem() != '') {
    //   Get.dialog(MessagePopUp(
    //     '에러',
    //     controller.checkInputItem(),
    //     okCallback: () {
    //       Get.back();
    //     },
    //     cancelCallback: () {
    //       Get.back();
    //     },
    //   ));
    //   return;
    // }

    //저장 전 model로 전환
    form.save();
    _assignItemsToSave();
    var result;

    try {
      if (controller.addEditFlag.value == 'add') {
        result = await controller.saveEmployee();
      } else {
        result = await controller.updateEmployee();
      }

      if (result == 'success') {
        CustomSnackBar.showSuccessSnackBar(title: '성공', message: '저장하였습니다!');

        //저장 버튼 disable 처리
        controller.isModified.value = false;
        //저장 후 '직원정보(하단 아이콘)'->'직원조회' 화면 open
        BottomNavController.to.openEmployeeMainPage();
      } else {
        CustomSnackBar.showErrorSnackBar(title: '실패', message: '다시 시도하십시오!');
        controller.isSave.value = false;
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(title: '에러', message: e.toString());
      controller.isSave.value = false;
    }
  }

  //SaveButton
  Widget SaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        child: Stack(
          children: [
            RoundedButtonTypeOne(
              width: Get.width * 0.9,
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
                        child: !controller.isSaveLoading.value
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

  Widget HeaderForEdit() {
    return Container(
      height: Get.height * 0.12,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                //Back 아이콘 클릭 시 '직원정보(하단 아이콘)'->'직원조회' 화면 open
                BottomNavController.to.openEmployeeMainPage();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 22,
              )),
          Expanded(
              flex: 4,
              child: Text(
                '인사 정보',
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
                        final result = await controller.deleteEmployeeById(
                            controller.employee.value.id.toString());
                        Get.back();

                        if (result == 'deleted') {
                          CustomSnackBar.showSuccessSnackBar(
                              title: '성공', message: '삭제 완료!');

                          //저장 버튼 disable 처리
                          controller.isModified.value = false;
                          //저장 후 '직원정보(하단 아이콘)'->'직원조회' 화면 open
                          BottomNavController.to.openEmployeeMainPage();
                        } else {
                          CustomSnackBar.showErrorSnackBar(
                              title: '실패', message: '다시 시도하십시오!');
                          controller.isSave..value = false;
                        }
                      }, cancelCallback: Get.back));
                    },
              icon: Icon(Icons.delete_forever))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //comment(2024.06.03)
    // employeeDropD-ownController.selectedRoleName.value = 'Mobile';

    //BottomNavController->openEmployeeMainPage() 호출 시 'Looking up a deactivated widgets ancestor is unsafe' 에러 발생
    //EmployeeMainController 에서 선언한 conTxt에 현재 context를 넣어줌!
    //????? ljk
    // EmployeeMainController.to.conTxt = context;

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Obx(
            () => SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidateMode.value,
                child: Column(
                  children: [
                    controller.addEditFlag.value == 'edit'
                        ? HeaderForEdit()
                        : Container(),
                    controller.addEditFlag.value == 'edit'
                        ? MenuDivider(
                            width: Get.width,
                          )
                        : Container(),
                    SizedBox(
                      height: 8,
                    ),
                    PhotoPart(),
                    InputBodyOne(),
                    InputBodyTwo(),
                    _PartDivider(),
                    InputBodyThree(),
                    SaveButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
