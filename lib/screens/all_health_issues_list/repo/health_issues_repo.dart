import '../../../core/api_service/app_url.dart';
import '../../../core/api_service/network_api_service.dart';
import '../model/health_issues_model.dart';

class AllHealthIssuesListRepository {
  final _apiService = NetworkApiServices();

  Future<AllHealthIssuesModel> getAllHealthIssuesListApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.getAllSymptoms);
      print('resssposssnscee:$response');
      return AllHealthIssuesModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}