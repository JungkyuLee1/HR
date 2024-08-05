// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hr2024/src/bindings/init_binding.dart';
//
// enum CostTabName{
//   inquire('inquire', '전체비용'),
//   register('register', '비용등록');
//
// const CostTabName(this.englishName, this.koreanName);
// final String englishName;
// final String koreanName;
// }
//
// class TabBarCostController extends GetxController with GetSingleTickerProviderStateMixin{
//   static TabBarCostController get to=>Get.find();
//
//   late TabController costTabController;
//   var addEdit = 'add'.obs;
//
//   List<Tab> tabs=List.generate(CostTabName.values.length, (index) => Tab(
//     text: CostTabName.values[index].koreanName,
//     icon: iconType(index),
//   ));
//
//   @override
//   void onInit() {
//     super.onInit();
//     costTabController = TabController(length: CostTabName.values.length, vsync: this);
//     //Cost 관련 controller 기동
//     InitBinding.costRegisterBinding(); //Loading
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     costTabController.dispose();
//   }
//
//   static Icon iconType(index){
//     final type = CostTabName.values[index].koreanName;
//     Icon icon;
//
//     switch(type){
//       case '전체비용' :
//         icon =Icon(Icons.calculate_outlined);
//         break;
//       case '비용등록' :
//         icon = Icon(Icons.app_registration_outlined);
//         break;
//       default:
//         icon=Icon(Icons.person);
//         break;
//     }
//     return icon;
//   }
// }