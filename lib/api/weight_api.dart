import 'package:tracker/models/weight_model.dart';

import '../mixin/http_middleware.dart';

abstract class WeightApi {
  Future<Weight> saveWeight(encodedParams);
  Future<Weight> updateWeight(encodedParams);
  Future<List<Weight>> getWeightHistory();
}

class UseWeightApi extends HttpMiddleware implements WeightApi {
  Future<Weight> saveWeight(encodedParams) async {
    final response = await withPost('weight/add', encodedParams);
    if (response['success']) {
      return Weight.fromJson(response['data']);
    }
     throw response['message'];
  }

  Future<Weight> updateWeight(encodedParams) async {
    final response = await withPost('weight/update', encodedParams);
    if (response['success']) {
      return Weight.fromJson(response['data']);
    }
     throw response['message'];
  }

  Future<List<Weight>> getWeightHistory() async {
    List<Weight> weightHistory = [];
    final response = await withGet('weight/history');
    if (response['success'] && response['data'] != null) {
      response['data'].map((e) => weightHistory.add(Weight.fromJson(e))).toList();
    }
    return weightHistory;
  }
}
