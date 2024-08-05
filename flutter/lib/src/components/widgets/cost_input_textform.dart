import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_addedit_controller.dart';

class CostInputTextForm extends StatelessWidget {
  CostInputTextForm(
      this.textEditingController, this.title, this.errorMessage, this.type,
      {required this.icon, Key? key})
      : super(key: key);

  final TextEditingController? textEditingController;
  final String title;
  final String errorMessage;
  final Icon? icon;
  final String type;

  CostAddEditController costAddEditController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enabled: AppController.to.isAdmin.value ? true : false,
      readOnly: type == 'paymentDate' || type == 'expiryDate' ? true : false,
      textInputAction: TextInputAction.done,
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
        if (type == 'paymentCard' || type == 'email' || type == 'remark') {
        } else {
          if (value == null || value.isEmpty) {
            return errorMessage;
          }
          return null;
        }
      },
      onTap: () {
        if (type == 'paymentDate' || type == 'expiryDate') {
          costAddEditController.chooseDate(type);
          costAddEditController.isModified.value = true;
        }
      },
      onChanged: (value) {
        //어떤 항목이 수정 되었을 경우
        if (value != null || !value.isEmpty) {
          costAddEditController.isModified.value = true;
        }
      },
      onSaved: (value) {
        switch (type) {
          case 'serviceName':
            costAddEditController.serviceName.value = value!;
            break;
          case 'paymentDate':
            costAddEditController.paymentDate.value = DateTime.parse(value!);
            break;
          case 'expiryDate':
            costAddEditController.expiryDate.value = DateTime.parse(value!);
            break;
          case 'amount':
            costAddEditController.amount.value = value!;
            break;
          case 'paymentCard':
            costAddEditController.paymentCard.value = value!;
            break;
          case 'email':
            costAddEditController.email.value = value!;
            break;
          case 'remark':
            costAddEditController.remark.value = value!;
            break;
          default:
            break;
        }
      },
    );
  }
}
