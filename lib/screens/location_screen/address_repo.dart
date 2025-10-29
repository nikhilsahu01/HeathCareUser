
import '../../core/api_service/app_url.dart';
import '../../core/api_service/network_api_service.dart';
import 'address_model.dart';

class AddressReo{
  final _apiService = NetworkApiServices();

  Future<AddressModel> getFullAddressApi() async {
    try {
      final response = await _apiService.getApiWithToken('${AppUrl.userAddress}/list');
      print('Response: $response');
      return AddressModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<bool> createAddressApi({
    required String floor,
    required String mobileNumber,
    required String addressLine1,
    required String addressLine2,
    required String landmark,
    required String city,
    required String state,
    required String country,
    required String pincode,
    required String latitude,
    required String longitude,
    required String addressType,
    required bool isDefault,
  }) async {
    final Map<String, dynamic> data = {
      "floor": floor,
      "mobileNumber": mobileNumber,
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "landmark": landmark,
      "city": city,
      "state": state,
      "country": country,
      "pincode": pincode,
      "latitude": latitude,
      "longitude": longitude,
      "addressType": addressType,
      "isDefault": isDefault,
    };

    try {
      final response = await _apiService.postApiWithToken(
        data,
        '${AppUrl.userAddress}/createAddress',
      );

      // Assume API returns: { "success": true, "message": "...", "data": {...} }
      return response['success'] == true;
    } catch (e) {
      return false;
    }
  }


  Future<bool> updateAddressApi({
    required String id,
    required String floor,
    required String mobileNumber,
    required String addressLine1,
    required String addressLine2,
    required String landmark,
    required String city,
    required String state,
    required String country,
    required String pincode,
    required String latitude,
    required String longitude,
    required String addressType,
    required bool isDefault,
  }) async {
    final Map<String, dynamic> data = {
      "floor": floor,
      "mobileNumber": mobileNumber,
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "landmark": landmark,
      "city": city,
      "state": state,
      "country": country,
      "pincode": pincode,
      "latitude": latitude,
      "longitude": longitude,
      "addressType": addressType,
      "isDefault": isDefault,
    };

    try {
      final response = await _apiService.patchApiWithToken(
        data,
        '${AppUrl.userAddress}/updateAddress/$id',
      );

      // ✅ Expecting API returns something like { "success": true, "message": "...", "data": {...} }
      return response['success'] == true;
    } catch (e) {
      return false; // or rethrow if you want error handling higher up
    }
  }

  Future<AddressModel> deleteAddressApi(var data, String id) async {
    try {
      final response = await _apiService.deleteApiWithToken('${AppUrl.userAddress}/deleteAddress/$id');
      print('Response: $response');
      return AddressModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}