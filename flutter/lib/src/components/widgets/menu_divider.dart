import 'package:flutter/material.dart';
import 'package:get/get.dart';

//최상단 구분선(메뉴 아래)
class MenuDivider extends StatelessWidget {
   MenuDivider({required this.width, Key? key}) : super(key: key);

  double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: width,
      decoration: BoxDecoration(color: Colors.grey[200]),
    );
  }
}
