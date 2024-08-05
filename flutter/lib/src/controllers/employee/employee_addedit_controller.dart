import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/employee/employee_dropdownmenu_controller.dart';
import 'package:hr2024/src/models/employee_model.dart';
import 'package:hr2024/src/repositories/employee_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class EmployeeAddEditController extends GetxController {
  static EmployeeAddEditController get to => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled.obs;

  late TextEditingController nameController;
  late TextEditingController entryDateController;
  late TextEditingController birthDateController;
  late TextEditingController careerController;
  late TextEditingController salaryController;
  late TextEditingController skillController;
  late TextEditingController hpController;
  late TextEditingController emailController;
  late TextEditingController? familyController;
  late TextEditingController? bankController;
  late TextEditingController? bankAccountController;
  late TextEditingController? remarkController;

  //저장 버튼 on/off flag(입력항목 모두 입력되었을 때 true로 전환)
  var isSave = false.obs;

  //저장 버튼 클릭 후 처리중에는 CircularProgressIndicator()로 보여주기 위한 flag
  var isSaveLoading = false.obs;

  //Field 수정이 되어야만 저장 버튼 on처리
  var isModified = false.obs;

  var selectedIndex = 0.obs;
  var selectedDate = DateTime.now().obs;
  var name = ''.obs;
  var entryDate = DateTime.now().obs;
  var birthDate = DateTime.now().obs;
  var career = 0.0.obs;
  var salary = 0.obs;
  var skill = ''.obs;
  var hp = ''.obs;
  var email = ''.obs;
  var family = ''.obs;
  var bank = ''.obs;
  var bankAccount = ''.obs;
  var remark = ''.obs;
  var employee = Rx<EmployeeModel>(EmployeeModel.initial());
  var addEditFlag = 'add'.obs;
  var imageUrl = ''.obs;
  String errorMessage = '';

  ImagePicker _picker = ImagePicker();
  File? image;
  final selectedImage = Rxn<File>();
  final lstSelectedImage = <File>[].obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    entryDateController = TextEditingController();
    birthDateController = TextEditingController();
    careerController = TextEditingController();
    salaryController = TextEditingController();
    skillController = TextEditingController();
    hpController = TextEditingController();
    emailController = TextEditingController();
    familyController = TextEditingController();
    bankController = TextEditingController();
    bankAccountController = TextEditingController();
    remarkController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    entryDateController.dispose();
    birthDateController.dispose();
    careerController.dispose();
    salaryController.dispose();
    skillController.dispose();
    hpController.dispose();
    emailController.dispose();
    familyController!.dispose();
    bankController!.dispose();
    bankAccountController!.dispose();
    remarkController!.dispose();
  }

  //Image Picker
  Future getImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // selectedImage.value = File(pickedImage.path);
      selectedImage.value= await compressAndGetFile(File(pickedImage.path));

      //서버로 List Type으로 넘김
      lstSelectedImage.value.clear();
      lstSelectedImage.value.add(selectedImage.value!);
    }
  }

  //Image Compress
  Future<File> compressAndGetFile(File file) async{
    final Directory tempDir=await getTemporaryDirectory();
    final String targetPath ='${tempDir.path}/${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}.jpg';
    // final String targetPath ='${tempDir.path}/compressed_image.jpg';

    var resultXFile=await FlutterImageCompress.compressAndGetFile(file.absolute.path, targetPath,quality: 50);
    File _file=File(resultXFile!.path);
    return _file!;
  }


  //DatePicker (입사일자,생년월일 입력)
  chooseDate(String item) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1975),
      lastDate: DateTime(2030),
      // initialEntryMode: DatePickerEntryMode.input,
      // initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select Date',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      fieldLabelText: 'Input Date',
    );
    if (selectedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate ?? selectedDate.value;
      if (item == 'entryDate') {
        entryDateController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate.value);
        entryDate.value = selectedDate.value;
      } else if (item == 'birthDate') {
        birthDateController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate.value);
        birthDate.value = selectedDate.value;
      }
    }
  }

  //Page 변경
  void pageChanged(int index) {
    selectedIndex(index);
  }

  //입력항목 check(저장 전)
  String checkInputItem() {
    errorMessage = '';

    if (name.value == null ||
        name.value.isEmpty ||
        name.value.trim().isBlank!) {
      errorMessage = '성명을 입력하세요';
    } else if (EmployeeDropDownMenuController.to.selectedRoleName.value ==
        '역할') {
      errorMessage = '역할을 입력하세요';
    } else if (entryDateController.text == '') {
      errorMessage = '입사일자를 입력하세요';
    } else if (career.value == 0.0) {
      errorMessage = '경력(년)을 입력하세요';
    } else if (salary.value == 0) {
      errorMessage = '급여를 입력하세요';
    } else if (skill.value == '') {
      errorMessage = '보유기술을 입력하세요';
    } else if (hp.value == '') {
      errorMessage = '핸드폰을 입력하세요';
    }
    return errorMessage;
  }

  //직원정보 저장
  Future<String> saveEmployee() async {
    var result;

    try {
      isSave.value = true;
      isSaveLoading.value = true;

      result = await EmployeeRepository.to
          .saveEmployee(employee.value, lstSelectedImage.value);
      isSaveLoading.value = false;
    } catch (e) {
      isSave.value = false;
      isSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //직원정보 수정
  Future<String> updateEmployee() async {
    var result;

    try {
      isSave.value = true;
      isSaveLoading.value = true;

      await Future.delayed(Duration(seconds: 1));
      result = await EmployeeRepository.to
          .updateEmployee(employee.value, lstSelectedImage.value);
      isSaveLoading.value = false;
    } catch (e) {
      isSave.value = false;
      isSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //직원정보 삭제
  Future<String> deleteEmployeeById(String id) async {
    var result;

    try {
      isSave.value = true;
      isSaveLoading.value = true;

      result = await EmployeeRepository.to.deleteEmployeeById(id);
      isSaveLoading.value = false;
    } catch (e) {
      isSave.value = false;
      isSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //저장 후 변수 초기화
  initializeFieldsAfterSave() {
    nameController = TextEditingController();
    selectedImage.value = null;
    EmployeeDropDownMenuController.to.selectedRoleName.value = 'Mobile';
    entryDateController = TextEditingController();
    birthDateController = TextEditingController();
    EmployeeDropDownMenuController.to.selectedUnitName.value = 'IDR';
    EmployeeDropDownMenuController.to.selectedHireTypeName.value = '정규직';
    EmployeeDropDownMenuController.to.selectedMaritalName.value = '미혼';
    careerController = TextEditingController();
    salaryController = TextEditingController();
    skillController = TextEditingController();
    hpController = TextEditingController();
    emailController = TextEditingController();
    familyController = TextEditingController();
    bankController = TextEditingController();
    bankAccountController = TextEditingController();
    remarkController = TextEditingController();
    //선택 사진 초기화
    lstSelectedImage.value.clear();
  }

  //해당직원 조회 시 직원정보 세팅(Edit 경우)
  setEmployeeDataForEdit() {
    //날짜 변환 (시분초 제거)
    //입사일자
    String yyyyMMddEntryDate = employee.value.entryDate.toString();
    String convEntryDate = yyyyMMddEntryDate.substring(0, 10);
    //생년월일
    String yyyyMMddBirthDate = employee.value.birthDate.toString();
    String convBirthDate = yyyyMMddBirthDate.substring(0, 10);

    nameController = TextEditingController(text: employee.value.name);
    imageUrl.value = employee.value.imageUrl ?? '';
    EmployeeDropDownMenuController.to.selectedRoleName.value =
        employee.value.role;

    entryDateController = TextEditingController(text: convEntryDate);
    birthDateController = TextEditingController(text: convBirthDate);
    EmployeeDropDownMenuController.to.selectedUnitName.value =
        employee.value.unit;
    EmployeeDropDownMenuController.to.selectedHireTypeName.value =
        employee.value.hireType;
    EmployeeDropDownMenuController.to.selectedMaritalName.value =
        employee.value.marital;
    careerController =
        TextEditingController(text: employee.value.career.toString());
    salaryController =
        TextEditingController(text: employee.value.salary.toString());
    skillController = TextEditingController(text: employee.value.skill);
    hpController = TextEditingController(text: employee.value.hp);
    emailController = TextEditingController(text: employee.value.email);
    familyController = TextEditingController(text: employee.value.family);
    bankController = TextEditingController(text: employee.value.bank);
    bankAccountController =
        TextEditingController(text: employee.value.bankAccount);
    remarkController = TextEditingController(text: employee.value.remark);

    //선택 사진 초기화
    lstSelectedImage.value.clear();
  }
}
