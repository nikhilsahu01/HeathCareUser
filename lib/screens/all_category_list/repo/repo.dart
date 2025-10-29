import '../../../core/api_service/app_url.dart';
import '../../../core/api_service/network_api_service.dart';
import '../model/all_categories_model.dart';

class CategoriesListRepository {
  final _apiService = NetworkApiServices();

  Future<HomeCategoryListModel> getCategoriesListApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.categoriesList);
      print('resssposssnscee:$response');
      return HomeCategoryListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}