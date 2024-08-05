import 'package:get/get.dart';
import 'package:hr2024/src/api/api.dart';
import 'package:hr2024/src/models/code_model.dart';
import 'package:hr2024/src/models/expense_model.dart';

class ExpenseRepository extends GetConnect {
  static ExpenseRepository get to => Get.find();

  //code 조회(Unit Code 정보(IDR, WON))
  Future<List<CodeModel>> getUnitCode() async {
    try {
      final response = await get(Api.baseUrl + '/expense/getUnitCode');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;
        final result = jsonData
            .map<CodeModel>((code) => CodeModel.fromJson(code))
            .toList();

        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  //경비지출 조회
  Future<List<ExpenseModel>> getAllByKind(String kind) async {
    try {
      final response = await get(Api.baseUrl + '/expense/getAllByKind/$kind');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;
        final result = jsonData
            .map<ExpenseModel>((expense) => ExpenseModel.fromJson(expense))
            .toList();

        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //경비지출 건별 조회
  Future<ExpenseModel> getExpenseById(String id) async {
    try {
      final response = await get(Api.baseUrl + '/expense/getExpenseById/$id');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;

        final result = ExpenseModel.fromJson(jsonData);
        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //경비 입출내역 저장
  Future<String> saveExpense(ExpenseModel expenseModel) async {
    try {
      final response =
          await post(Api.baseUrl + '/expense/save', expenseModel.toJson());

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var result = response.body;
        //result : success, fail
        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //경비입출 수정
  Future<String> updateExpense(ExpenseModel expenseModel) async {
    try {
      final response = await patch(
          Api.baseUrl + '/expense/update/${expenseModel.id}',
          expenseModel.toJson());

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var result = response.body;

        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error((e.toString()));
    }
  }

  //운영비용 삭제
  Future<String> deleteExpenseById(String id) async {
    try {
      final response = await delete(Api.baseUrl + '/expense/delete/$id',
          contentType: 'application/json');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var result = response.body;
        //result : deleted, fail
        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }
}
