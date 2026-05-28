

import 'package:health_care/search/model/search__model.dart';

import '../../core/api_service/app_url.dart';
import '../../core/api_service/network_api_service.dart';

class SearchRepo {

  final NetworkApiServices apiService =
  NetworkApiServices();

  Future<SearchModel> searchApi(String query) async {

    try {

      final response = await apiService.getApiWithToken(AppUrl.search);
      print('resssposssnscee:$response');
      return SearchModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}