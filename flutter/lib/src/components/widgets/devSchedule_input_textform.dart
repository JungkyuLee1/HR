import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/devSchedule/devSchedule_addedit_controller.dart';

class DevScheduleInputTextForm extends StatelessWidget {
  DevScheduleInputTextForm(
      this.textEditingController, this.title, this.errorMessage, this.type,
      {required this.icon, Key? key})
      : super(key: key);

  final TextEditingController? textEditingController;
  final String title;
  final String errorMessage;
  final Icon? icon;
  final String type;

  DevScheduleAddEditController devScheduleAddEditController =
      Get.find<DevScheduleAddEditController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      // textInputAction: TextInputAction.done,
      enabled: AppController.to.isAdmin.value ? true : false,
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
      maxLines: type=='detail' ? 5 : 1,
      maxLength: type=='detail' ? 590 : 96,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
      onChanged: (value) {
        //어떤 항목이 수정 되었을 경우
        if (value != null || !value.isEmpty) {
          devScheduleAddEditController.isModified.value = true;
        }
      },
      onSaved: (value) {
        switch (type) {
          case 'title':
            devScheduleAddEditController.title.value = value!;
            break;
          case 'detail':
            devScheduleAddEditController.detail.value = value!;
            break;
          default:
            break;
        }
      },
    );
  }
}
