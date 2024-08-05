import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/common/util.dart';
import 'package:hr2024/src/controllers/expense/expense_addedit_controller.dart';
import 'package:hr2024/src/controllers/expense/expense_display_controller.dart';
import 'package:hr2024/src/models/expense_model.dart';
import 'package:hr2024/src/pages/expense/expense_addedit_page.dart';

class ExpenseDisplay extends GetView<ExpenseDisplayController> {
  ExpenseDisplay({Key? key}) : super(key: key);

  TextStyle textStyle = TextStyle(fontSize: 14, color: Colors.white);

  //1
  TotalBalance() {
    return Text(
      '1.잔액 : ${commaConvert(controller.incomeOutcomeBalance.value.toString())}',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      textScaler: TextScaler.linear(1),
    );
  }

  //2-1(Title)
  TitleOne(String tNo, String tInOutDate, String tItem, String tAmount,
      String tRemark) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.06,
              child: Text(
                tNo,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.21,
              child: Text(
                tInOutDate,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.25,
              child: Text(
                tItem,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.18,
              child: Text(
                tAmount,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.20,
              child: Text(
                tRemark,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
        ],
      ),
    );
  }

  //2-2-1
  IncomeDataOne(BuildContext context, int index, ExpenseModel incomeExpense) {
    return GestureDetector(
      onTap: () async {
        //해당 경비 선택(수입) 시 1.'edit' 2.선택 건 expense obs에 할당 3.각 field에 경비정보 setting
        ExpenseAddEditController.to.addEditExpenseFlag.value = 'edit';
        ExpenseAddEditController.to.expense.value = incomeExpense;
        ExpenseAddEditController.to.setExpenseDataForEdit();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ExpenseAddEdit()));
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 5),
                  width: Get.width * 0.06,
                  child: CircleAvatar(
                    child: Text(
                      '${index + 1}'.toString(),
                      textScaler: TextScaler.linear(1),
                    ),
                    radius: 13,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.21,
                  child: Text(
                    '${incomeExpense.inOutcomeDate.toString().substring(0, 10)}',
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.linear(1),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.25,
                  child: Text(
                    '${incomeExpense.item}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.linear(1),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.18,
                  child: Text(
                    '${commaConvert(incomeExpense.amount.toString())}',
                    textAlign: TextAlign.right,
                    textScaler: TextScaler.linear(1),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.20,
                  child: Text(
                    '${incomeExpense.remark}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.linear(1),
                  )),
            ],
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }

  //2-2
  IncomeData() {
    return Expanded(
      child: Container(
        // height: Get.width * 0.41,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        child: controller.isDataProcessing.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => controller.getAllByKind('IN'),
                child: ListView.builder(
                    itemCount: controller.lstIncomeExpense.value.length,
                    itemBuilder: (context, index) {
                      final incomeExpense =
                          controller.lstIncomeExpense.value[index];
      
                      return IncomeDataOne(context, index, incomeExpense);
                    }),
              ),
      ),
    );
  }

  //2-3
  IncomePart() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2.입금상세(총액 : ${commaConvert(controller.incomeTotalAmount.value.toString())} IDR)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
              textScaler: TextScaler.linear(1),
            ),
            SizedBox(
              height: 2,
            ),
            TitleOne('No', '입금일자', '항목', '금액(IDR)', '비고'),
            SizedBox(
              height: 1,
            ),
            IncomeData(),
            SizedBox(
              height: 2,
            )
          ],
        ),
        // Positioned(
        //     top: Get.width * 0.2,
        //     left: Get.width * 0.43,
        //     right: Get.width * 0.43,
        //     child: controller.isDataProcessing.value
        //         ? CircularProgressIndicator()
        //         : Container())
      ],
    );
  }

  //3-1-1
  //2-2-1
  OutcomeDataOne(
    BuildContext context,
    int index,
    ExpenseModel outcomeExpense,
  ) {
    return GestureDetector(
      onTap: () async {
        //해당 경비 선택(지출) 시 1.'edit' 2.선택 건 expense obs에 할당 3.각 field에 경비정보 setting
        ExpenseAddEditController.to.addEditExpenseFlag.value = 'edit';
        ExpenseAddEditController.to.expense.value = outcomeExpense;
        ExpenseAddEditController.to.setExpenseDataForEdit();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ExpenseAddEdit()));
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 4),
                  width: Get.width * 0.06,
                  child: CircleAvatar(
                    child: Text(
                      '${index + 1}'.toString(),
                      textScaler: TextScaler.linear(1),
                    ),
                    radius: 12,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.21,
                  child: Text(
                    '${outcomeExpense.inOutcomeDate.toString().substring(0, 10)}',
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.linear(1),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.25,
                  child: Text(
                    '${outcomeExpense.item}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.linear(1),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.18,
                  child: Text(
                    '${commaConvert(outcomeExpense.amount.toString())}',
                    textAlign: TextAlign.right,
                    textScaler: TextScaler.linear(1),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.2,
                  child: Text(
                    '${outcomeExpense.remark}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.linear(1),
                  )),
            ],
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }

  //3-1
  OutcomeData() {
    return Expanded(
      child: Container(
        // height: Get.width * 0.43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        child: controller.isDataProcessing.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => controller.getAllByKind('OUT'),
                child: ListView.builder(
                    itemCount: controller.lstOutcomeExpense.value.length,
                    itemBuilder: (context, index) {
                      final expense = controller.lstOutcomeExpense.value[index];
      
                      return OutcomeDataOne(context, index, expense);
                    }),
              ),
      ),
    );
  }

  //3
  OutcomePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '3.출금상세(총액 : ${commaConvert(controller.outcomeTotalAmount.value.toString())} IDR)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textScaler: TextScaler.linear(1),
        ),
        SizedBox(
          height: 2,
        ),
        TitleOne('No', '출금일자', '항목', '금액(IDR)', '비고'),
        SizedBox(
          height: 1,
        ),
        OutcomeData(),
        SizedBox(
          height: 2,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TotalBalance(),
              SizedBox(
                height: 5,
              ),
              Expanded(child: IncomePart()),
              SizedBox(height: 5,),
              Expanded(child: OutcomePart()),
              // OutcomePart(),
            ],
          ),
        ),
      ),
    );
  }
}
