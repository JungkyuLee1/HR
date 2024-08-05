import 'package:get/get.dart';
import 'package:hr2024/src/api/api.dart';
import 'package:hr2024/src/models/memo_model.dart';

class MemoRepository extends GetConnect {
  static MemoRepository get to => Get.find();

  //메모 전체 불러오기(1건 만 존재, 1개 메모에서 입력/수정 반복(Replace))
  Future<MemoModel> getMemo() async {
    try {
      final response = await get(Api.baseUrl + '/memo/getMemo');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;

        var result;
        if (jsonData == null) {
          result = MemoModel.initial();
        } else {
          result = MemoModel.fromJson(jsonData);
        }
        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //메모 건별 조회
  Future<MemoModel> getMemoById(String id) async {
    try {
      final response = await get(Api.baseUrl + '/memo/getMemoById/$id');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;

        final result = MemoModel.fromJson(jsonData);
        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //메모 저장
  Future<String> saveMemo(MemoModel memoModel) async {
    try {
      final response =
          await post(Api.baseUrl + '/memo/save', memoModel.toJson());

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

  //메모 수정
  Future<String> updateMemo(MemoModel memoModel) async {
    try {
      final response = await patch(
          Api.baseUrl + '/memo/update/${memoModel.id}', memoModel.toJson());

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
}
