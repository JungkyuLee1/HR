import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_addedit_controller.dart';

class EmployeeInputTextForm extends StatelessWidget {
  EmployeeInputTextForm(
      this.textEditingController, this.title, this.errorMessage, this.type,
      {required this.icon, Key? key})
      : super(key: key);

  final TextEditingController? textEditingController;
  final String title;
  final String errorMessage;
  final Icon? icon;
  final String type;

  EmployeeAddEditController employeeAddEditController =
      Get.find<EmployeeAddEditController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enabled: AppController.to.isAdmin.value ? true : false,
      readOnly: type == 'entryDate' ? true : false,
      inputFormatters: type == 'career' || type == 'salary'
          ? [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))]
          : null,
      // textInputAction: TextInputAction.next,
      keyboardType:
          type == 'career' || type == 'salary' ? TextInputType.number : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        prefixIcon: icon != null ? icon : null,
        label: Text(
          title,
          style: TextStyle(fontSize: 14),
          textScaler: TextScaler.linear(1),
        ),
      ),
      style: TextStyle(fontSize: 14,color: AppController.to.isAdmin.value ? Colors.black : Colors.black),
      validator: (value) {
        if (type == 'family' ||
            type == 'bank' ||
            type == 'bankAccount' ||
            type == 'remark') {
        } else {
          if (value == null || value.isEmpty) {
            return errorMessage;
          }
          return null;
        }
      },
      onTap: () {
        if (type == 'entryDate' || type == 'birthDate') {
          employeeAddEditController.chooseDate(type);
          employeeAddEditController.isModified.value = true;
        }
      },
      onChanged: (value) {
        //어떤 항목이 수정 되었을 경우
        if (value != null || !value.isEmpty) {
          employeeAddEditController.isModified.value = true;
        }
      },
      onSaved: (value) {
        switch (type) {
          case 'name':
            employeeAddEditController.name.value = value!.trim();
            break;
          case 'entryDate':
            employeeAddEditController.entryDate.value = DateTime.parse(value!.trim());
            break;
          case 'career':
            employeeAddEditController.career.value = double.parse(value!.trim());
            break;
          case 'salary':
            employeeAddEditController.salary.value = int.parse(value!.trim());
            break;
          case 'skill':
            employeeAddEditController.skill.value = value!.trim();
            break;
          case 'hp':
            employeeAddEditController.hp.value = value!.trim();
            break;
          case 'email':
            employeeAddEditController.email.value = value!.trim();
            break;
          case 'birthDate':
            employeeAddEditController.birthDate.value = DateTime.parse(value!.trim());
            break;
          case 'family':
            employeeAddEditController.family.value = value!.trim();
            break;
          case 'bank':
            employeeAddEditController.bank.value = value!.trim();
            break;
          case 'bankAccount':
            employeeAddEditController.bankAccount.value = value!.trim();
            break;
          case 'remark':
            employeeAddEditController.remark.value = value!.trim();
            break;
          default:
            break;
        }
      },
    );
  }
}
