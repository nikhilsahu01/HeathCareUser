

import '../../../../core/api_service/app_url.dart';
import '../../../../core/api_service/network_api_service.dart';

class CmsRepo {

  final _api = NetworkApiServices();

  Future<dynamic> getCmsData() async {

    dynamic response = await _api.getApiWithToken(
      AppUrl.cmsData,
    );

    return response;
  }
}