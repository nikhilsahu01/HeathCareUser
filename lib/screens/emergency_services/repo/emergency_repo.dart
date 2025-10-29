import '../../../core/api_service/app_url.dart';
import '../../../core/api_service/network_api_service.dart';
import '../model/add_address_manually_model.dart';
import '../model/add_address_manually_model_troma.dart';

class EmergencyServicesRepo {
  final _apiService = NetworkApiServices();

  Future<AmbulanceAddressModel> postFullAddressApi(var data) async {
    try {
      print("????????????sec?????????????????");
      final response = await _apiService.postApiWithToken(data, AppUrl.ambulanceBooking);
      print("????????????345?????????????????");  print('url$response');
      print('Response: $response');
      return AmbulanceAddressModel.fromJson(response);
      print('$response');
    } catch (e) {
      rethrow;
    }


  }
  Future<TraumaAddressModel> postAccidentalTraumaApi(var data) async {
    try {
      print("????????????sec?????????????????");
      final response = await _apiService.postApiWithToken(data, AppUrl.traumaCreate);
      print("????????????345?????????????????");  print('url$response');
      print('Response: $response');
      return TraumaAddressModel.fromJson(response);
      print('$response');
    } catch (e) {
      rethrow;
    }


  }
}