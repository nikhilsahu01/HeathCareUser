

import '../../../../core/api_service/app_url.dart';
import '../../../../core/api_service/network_api_service.dart';

class RegistrationRepo{
  final _apiService = NetworkApiServices();

 
  Future<bool> registrationApi({
    required String name,//"name", "mobileNo", "dob", "gender", "address"
    required String mobileNo,
    required String dob,
    required String gender,
    required String address,
  }) async {
    final Map<String, dynamic> data = {
      "name": name,
      "mobileNo": mobileNo,
      "dob": dob,
      "gender": gender,
      "address": address,
    };

    try {
      final response = await _apiService.postApiWithToken(
        data,
        AppUrl.registerApi,
      );

      // Assume API returns: { "success": true, "message": "...", "data": {...} }
      return response['success'] == true;
    } catch (e) {
      return false;
    }
  }
  ///api/user/common/userWelcomeNotification
Future<dynamic> welcomeNotificationApi() async {
    try {
      dynamic response =
      await _apiService.getApiWithToken(AppUrl.welcome);
      return response;
    } catch (e) {
      throw e;
    }
  }
}