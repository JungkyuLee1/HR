import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/widgets/menu_divider.dart';
import 'package:hr2024/src/controllers/cost/cost_addedit_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_display_controller.dart';
import 'package:hr2024/src/models/cost_model.dart';
import 'package:hr2024/src/pages/cost/cost_add_edit_page.dart';
import 'package:intl/intl.dart';

class CostDisplay extends GetView<CostDisplayController> {
  CostDisplay({Key? key}) : super(key: key);

  TextStyle textStyle = TextStyle(fontSize: 14, color: Colors.white);

  //2-1
  Widget makeItem(Alignment alignment, double widthRatio, String text, double fontSize) {
    return Container(
        // margin: EdgeInsets.symmetric(horizontal: 1),
        // color: Colors.yellow,
        alignment: alignment,
        width: Get.width * widthRatio,
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
          textScaler: TextScaler.linear(1),
        ));
  }

  //1-1.
  Widget _makeHeader(double widthRatio, String text, double fontSize) {
    return Container(
      width: Get.width * widthRatio,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              fontSize: fontSize),
          textScaler: TextScaler.linear(1),
        ),
      ),
    );
  }

  CostOne(BuildContext context, int index, CostModel cost) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () async {
          //해당 비용 선택 시 1.'edit' 2.선택 건 cost obs에 할당 3.각 field에 비용정보 setting
          CostAddEditController.to.addEditCostFlag.value = 'edit';
          CostAddEditController.to.cost.value = cost;
          CostAddEditController.to.setCostDataForEdit();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CostAddEdit()));
        },
        child: Card(
          color: Colors.grey[100],
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: Text(
                    '${index + 1}',
                    textScaler: TextScaler.linear(1),
                  ),
                  radius: 15,
                ),
                SizedBox(width: 5),
                makeItem(Alignment.centerLeft,0.41, cost.serviceName, 15),
                makeItem(Alignment.centerRight,0.09, cost.amount, 15),
                makeItem(Alignment.center,0.1, cost.paymentUnit, 15),
                makeItem(Alignment.centerRight,
                    0.23, DateFormat('yyyy-MM-dd').format(cost.dueDate), 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //0.CostBody
  CostBody() {
    return controller
            .isDataProcessing.value //하단 '운영비용' 재 클릭 시 화면 refresh도 하게함(중요)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () => controller.getAllCost(),
            child: ListView.builder(
              key: PageStorageKey(UniqueKey),
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: controller.lstOperationCost.value.length,
                itemBuilder: (context, index) {
                  final cost = controller.lstOperationCost.value[index];

                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: CostOne(context, index, cost));
                }),
          );
  }

  //1-1-1(Title 상세)
  TitleOne(
      String tNo, String tTitle, String tAmount, String tDueDate) {
    return Container(
      margin: EdgeInsets.only(left:8, right: 13),
      decoration: BoxDecoration(color: Colors.black),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              margin: EdgeInsets.only(left: 2),
              width: Get.width * 0.08,
              child: Text(
                tNo,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.39,
              child: Text(
                tTitle,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.27,
              child: Text(
                tAmount,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.16,
              child: Text(
                tDueDate,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
        ],
      ),
    );
  }

  //1-1.
  Title() {
    return TitleOne('No', '서비스 명', '금액', '지급일자');
  }

  //1.Header & Title
  Widget Header() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Center(
              child: Text(
            '전체 항목',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textScaler: TextScaler.linear(1),
          )),
          SizedBox(height: 9,),
          Title(),
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Header(),
                  // MenuDivider(width: Get.width * 0.22),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  PageStorage(
                    bucket: controller.buckGlobal,
                    child: Expanded(
                      child: CostBody(),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}



//1.Futurebuilder 사용 경우 (Data 재조회 후 화면 갱신이 안됨(왜?)
//2.BottomNavController(74행,  CostDisplayController.to.getAllCost();)
//3.화면을 재 Open해야함 but 투박해 보임(Navigator.push( CostMain())~)

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hr2024/src/controllers/cost/cost_addedit_controller.dart';
// import 'package:hr2024/src/controllers/cost/cost_display_controller.dart';
// import 'package:hr2024/src/controllers/cost/tabbar_cost_controller.dart';
// import 'package:hr2024/src/models/cost_model.dart';
// import 'package:hr2024/src/pages/cost/cost_add_edit_page.dart';
// import 'package:hr2024/src/pages/cost/cost_main_page.dart';
// import 'package:intl/intl.dart';
//
// class CostDisplay extends GetView<CostDisplayController> {
//   CostDisplay({Key? key}) : super(key: key);
//
//   // CostDisplayController costDisplayController = Get.find();
//
//   //2-1
//   Widget makeItem(double widthRatio, String text, double fontSize) {
//     return Container(
//         // margin: EdgeInsets.symmetric(horizontal: 1),
//         // color: Colors.yellow,
//         width: Get.width * widthRatio,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: fontSize),
//         ));
//   }
//
//   //2
//   Widget buildCost(List<CostModel> costs) {
//     if (costs.isEmpty) {
//       print('nulled');
//     }
//     // print('costs :${costs[0].serviceName}');
//     return ListView.builder(
//         physics: BouncingScrollPhysics(),
//         itemCount: costs.length,
//         itemBuilder: (context, index) {
//           final cost = costs[index];
//           print('costData :${cost.serviceName}');
//
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
//             child: GestureDetector(
//               onTap: () async {
//                 //해당 직원 선택 시 1.'edit' 2.선택 건 employee obs에 할당 3.각 field에 직원정보 setting
//                 CostAddEditController.to.addEditCostFlag.value='edit';
//                 CostAddEditController.to.cost.value=cost;
//                 CostAddEditController.to.setCostDataForEdit();
//
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => CostAddEdit()
//                     ));
//               },
//               child: Card(
//                 color: Colors.grey[100],
//                 elevation: 0,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.grey.shade300,
//                         child: Text('${index + 1}'),
//                         radius: 15,
//                       ),
//                       SizedBox(width: 5),
//                       makeItem(0.4, cost.serviceName, 15),
//                       makeItem(0.12, cost.amount, 15),
//                       makeItem(0.09, cost.paymentUnit,15),
//                       makeItem(0.2,
//                           DateFormat('yyyy-MM-dd').format(cost.expiryDate), 15),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//
//   //1-1.
//   Widget _makeHeader(double widthRatio, String text, double fontSize) {
//     return Container(
//       width: Get.width * widthRatio,
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(
//               decoration: TextDecoration.underline,
//               fontWeight: FontWeight.bold,
//               fontSize: fontSize),
//         ),
//       ),
//     );
//   }
//
//   //1.Header
//   Widget _Header() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//       child: Row(
//         children: [
//           _makeHeader(0.07, 'No.', 15),
//           SizedBox(
//             width: 5,
//           ),
//           _makeHeader(0.38, '서비스 명', 15),
//           SizedBox(
//             width: 5,
//           ),
//           _makeHeader(0.25, '금액', 15),
//           SizedBox(
//             width: 5,
//           ),
//           _makeHeader(0.2, '만료일자', 15),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //FutureBuilder 에서는 Obx 불필요(이유 : FutureBuilder 자체가 모든 Data를 기다렸다가 한번에 display하기 때문)
//     //controller.getAllCost()의 await Future.delayed()..중요
//
//     print('starttt');
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: FutureBuilder<List<CostModel>>(
//               future: controller.getAllCost(),
//               builder: (context, AsyncSnapshot<List<CostModel>> snapshot) {
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                     return Center(child: CircularProgressIndicator());
//                   case ConnectionState.done:
//                   default:
//                     if (snapshot.hasError) {
//                       return Center(child: Text('${snapshot.error}'));
//                     } else if (snapshot.hasData && !snapshot.data!.isEmpty) {
//                       final costs = snapshot.data;
//
//                       // print('costServiceName : ${costs![0].serviceName}');
//                       // Future.delayed(Duration(seconds: 2));
//                       print('delayed');
//                       return Column(
//                         children: [
//                           _Header(),
//                           Expanded(child: buildCost(costs!)),
//                         ],
//                       );
//                     } else {
//                       return Center(
//                         child: Text('No Data Found'),
//                       );
//                     }
//                 }
//               }),
//       );
//   }
// }
