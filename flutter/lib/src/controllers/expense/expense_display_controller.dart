import 'package:get/get.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/models/expense_model.dart';
import 'package:hr2024/src/repositories/expense_repository.dart';

class ExpenseDisplayController extends GetxController {
  static ExpenseDisplayController get to => Get.find();

  var expense = Rx<ExpenseModel>(ExpenseModel.initial());
  var lstIncomeExpense = Rx<List<ExpenseModel>>([]);
  var lstOutcomeExpense = Rx<List<ExpenseModel>>([]);
  var isExpenseQueryLoading = true.obs;
  var isDataProcessing = false.obs;
  var incomeTotalAmount = 0.obs;
  var outcomeTotalAmount = 0.obs;
  var incomeOutcomeBalance = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getAllByKind('IN');
    getAllByKind('OUT');
  }

  getAllByKind(String kind) async {
    try {
      isDataProcessing(true);

      //Indicator를 보기위해 1초 기다림
      await Future.delayed(Duration(milliseconds: 500));
      ExpenseRepository.to.getAllByKind(kind).then((resp) {
        if (kind == 'IN') {
          isDataProcessing(false);
          lstIncomeExpense.value.clear();
          lstIncomeExpense.value.addAll(resp);
        } else {
          isDataProcessing(false);
          lstOutcomeExpense.value.clear();
          lstOutcomeExpense.value.addAll(resp);
        }
      }, onError: (err) {
        isDataProcessing(false);
        CustomSnackBar.showErrorSnackBar(title: '에러', message: 'Internet 접속이 불완전 합니다.\n다시 시도하여 주십시오');
        // CustomSnackBar.showErrorSnackBar(title: '에러', message: err.toString());
      });
    } catch (e) {
      isDataProcessing(false);
      CustomSnackBar.showErrorSnackBar(title: '예외', message: '서비스가 원할하지 않습니다.\n다시 시도하여 주십시오');
      // CustomSnackBar.showErrorSnackBar(title: '예외', message: e.toString());
    }
    //지출금액 조회 후 잔액 조회
    getIncomeOutcomeBalance(kind);
    // incomeTotalAmount.value=0;
    // outcomeTotalAmount.value=0;
  }

  //수입-지출(잔액)
  getIncomeOutcomeBalance(String kind) async {
    await Future.delayed(Duration(seconds: 1));

    if (kind == 'IN') {
      incomeTotalAmount.value=0;
      for (ExpenseModel exp in lstIncomeExpense.value) {
        incomeTotalAmount.value += exp.amount;
      }
    } else {
      outcomeTotalAmount.value=0;
      for (ExpenseModel exp in lstOutcomeExpense.value) {
        outcomeTotalAmount.value += exp.amount;
      }
    }
    incomeOutcomeBalance.value =
        incomeTotalAmount.value - outcomeTotalAmount.value;
  }
}
