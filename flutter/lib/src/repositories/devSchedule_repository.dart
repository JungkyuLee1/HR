import 'package:get/get.dart';
import 'package:hr2024/src/api/api.dart';
import 'package:hr2024/src/models/code_model.dart';
import 'package:hr2024/src/models/dev_schedule_model.dart';

class DevScheduleRepository extends GetConnect {
  static DevScheduleRepository get to => Get.find();

  //code 조회(개발일정 관련  )
  Future<List<CodeModel>> getDevCodes() async {
    try {
      final response = await get(Api.baseUrl + '/devSchedule/getDevCodes');

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

  //개발일정 전체(검색) 조회
  Future<List<DevScheduleModel>> getAllByTitleAndStatus(String title, String status) async {
    try {
      final response = await get(Api.baseUrl + '/devSchedule/getAllByTitleAndStatus?titleParam=$title&statusParam=$status');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;
        final result = jsonData
            .map<DevScheduleModel>((schedule) => DevScheduleModel.fromJson(schedule))
            .toList();

        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //개발일정 건별 조회
  Future<DevScheduleModel> getDevScheduleById(String id) async {
    try {
      final response = await get(Api.baseUrl + '/devSchedule/getDevScheduleById/$id');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;

        final result = DevScheduleModel.fromJson(jsonData);
        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //개발일정 건별 저장
  Future<String> saveDevSchedule(DevScheduleModel devScheduleModel) async {
    try {
      final response =
      await post(Api.baseUrl + '/devSchedule/save', devScheduleModel.toJson());

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

  //개발일정 건별 수정
  Future<String> updateDevSchedule(DevScheduleModel devScheduleModel) async {
    try {
      final response = await patch(
          Api.baseUrl + '/devSchedule/update/${devScheduleModel.id}',
          devScheduleModel.toJson());

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

  //개발일정 건별 삭제
  Future<String> deleteDevScheduleById(String id) async {
    try {
      final response = await delete(Api.baseUrl + '/devSchedule/delete/$id',
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
