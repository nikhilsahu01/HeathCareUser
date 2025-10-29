

import 'dart:io';

import '../../../../core/api_service/app_url.dart';
import '../../../../core/api_service/network_api_service.dart';
import '../model/profile_model.dart';

class ProfileRepo{
  final _apiService = NetworkApiServices();

  Future<ProfileUser> getProfileApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.profile);
      print('Response: $response');
      return ProfileUser.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<ProfileUser> updateProfileApi({
    required Map<String, String> fields,
    required Map<String, File> files,
  }) async {
    try {
      final response = await _apiService.patchMultipartApiWithToken(
        url: AppUrl.profile,
        fields: fields,
        files: files,
      );
      print('Update Profile Response: $response');
      return ProfileUser.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}