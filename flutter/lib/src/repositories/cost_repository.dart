import 'package:get/get.dart';
import 'package:hr2024/src/api/api.dart';
import 'package:hr2024/src/models/code_model.dart';
import 'package:hr2024/src/models/cost_model.dart';

class CostRepository extends GetConnect {
  static CostRepository get to => Get.find();

  //code 조회(운영비용 정보)
  Future<List<CodeModel>> getCostCodes() async {
    try {
      final response = await get(Api.baseUrl + '/operationCost/getCostCodes');

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

  //운영비용 조회
  Future<List<CostModel>> getAllCost() async {
    try {
      final response = await get(Api.baseUrl + '/operationCost/getAll');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;
        final result = jsonData
            .map<CostModel>(
                (cost) => CostModel.fromJson(cost))
            .toList();

        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //운영비용 건별 조회
  Future<CostModel> getCostById(String id) async {
    try {
      final response = await get(Api.baseUrl + '/operationCost/getById/$id');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;

        final result = CostModel.fromJson(jsonData);
        return result;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //운영비용 저장
  Future<String> saveCost(
      CostModel costModel) async {
    try {
      final response = await post(
          Api.baseUrl + '/operationCost/save', costModel.toJson());

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

  //운영비용 수정
  Future<String> updateCost(
      CostModel costModel) async {

    try {
      final response = await patch(
          Api.baseUrl + '/operationCost/update/${costModel.id}',
          costModel.toJson());

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
  Future<String> deleteCostById(String id) async {
    try {
      final response = await delete(Api.baseUrl + '/operationCost/delete/$id',
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
