import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/expense/expense_addedit_controller.dart';

class ExpenseInputTextForm extends StatelessWidget {
  ExpenseInputTextForm(
      this.textEditingController, this.title, this.errorMessage, this.type,
      {required this.icon, Key? key})
      : super(key: key);

  final TextEditingController? textEditingController;
  final String title;
  final String errorMessage;
  final Icon? icon;
  final String type;

  ExpenseAddEditController expenseAddEditController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enabled: AppController.to.isAdmin.value ? true : false,
      readOnly: type == 'expenseInOutDate' ? true : false,
      textInputAction: TextInputAction.done,
      keyboardType: type == 'amount' ? TextInputType.number : null,
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
        if (type == 'remark') {
        } else {
          if (value == null || value.trim().isEmpty) {
            return errorMessage;
          }
          return null;
        }
      },
      onTap: () {
        if (type == 'expenseInOutDate') {
          expenseAddEditController.chooseDate(type);
          expenseAddEditController.isModified.value = true;
        }
      },
      onChanged: (value) {
        //어떤 항목이 수정 되었을 경우
        if (value != null || !value.isEmpty) {
          expenseAddEditController.isModified.value = true;
        }
      },
      onSaved: (value) {
        switch (type) {
          case 'expenseInOutDate':
            expenseAddEditController.inOutcomeDate.value =
                DateTime.parse(value!);
            break;
          case 'item':
            expenseAddEditController.item.value = value!;
            break;
          case 'amount':
            expenseAddEditController.amount.value = int.parse(value!);
            break;
          case 'remark':
            expenseAddEditController.remark.value = value!;
            break;
          default:
            break;
        }
      },
    );
  }
}
