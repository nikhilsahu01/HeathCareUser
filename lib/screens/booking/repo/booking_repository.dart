import '../../../core/api_service/app_url.dart';
import '../../../core/api_service/network_api_service.dart';
import '../model/category_list_model.dart';
import '../model/consultant_details_model.dart';
import '../model/consultant_list_model.dart';
import '../model/patients_model.dart';
import '../model/slots_model.dart';
import '../model/symptoms_list_model.dart';

class BookingRepository {
  final _apiService = NetworkApiServices();

  Future<SymptomsListModel> getSymptomsListApi(String symName) async {
    try {
      final response = await _apiService.getApiWithToken('${AppUrl.symptomsList}/$symName');
      print('resssposssnscee:$response');
      return SymptomsListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoryListModel> getCategoryListApi(List<String> symptomIds) async {
    final Map<String, dynamic> data = {
      "symptoms": symptomIds,
    };

    try {
      final response = await _apiService.postApiWithToken(data, AppUrl.getCategoryList);
      return CategoryListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ConsultantListModel> getConsultantListApi(String categoryId,String categoryType) async {
    final Map<String, dynamic> data = {
      "type":categoryType,//"videoConsultant",'inclineConsultant'
      "categoryid":categoryId
    };

    try {
      final response = await _apiService.postApiWithToken(data, AppUrl.getDoctorsList);
      return ConsultantListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ConsultantDetailsModel> getConsultantDetailsApi(String consultantId) async {
    try {
      final response = await _apiService.getApiWithToken('${AppUrl.getDoctorDetails}/$consultantId');
      print('resssposssnscee:$response');
      return ConsultantDetailsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  Future<ReminderSlotsModel> getReminderSlots({
    required String vendorId,
    required String date,
  }) async {
    try {
      final response = await _apiService.getApiWithToken(
        '${AppUrl.reminderSlots}?vendorId=$vendorId&date=$date',
      );
      return ReminderSlotsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<AvailableSlotsModel> getAvailableSlots({
    required String vendorId,
    required String date,
    // required String tabType,
    // required String categoryId,
  }) async {
    final queryParams = {
      "vendorId": vendorId,
      "date": date,
      // "type": tabType,
      // "categoryid": categoryId,
    };

    final uri = Uri.parse(AppUrl.availableSlots).replace(queryParameters: queryParams);

    try {
      final response = await _apiService.getApiWithToken(uri.toString());
      return AvailableSlotsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  Future<PatientsModel> getPatientsList() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.patientsList);
      return PatientsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addNewPatient(String name) async {
    final body = { "name": name };

    try {
      final response = await _apiService.postApiWithToken(
        body,
        AppUrl.createPatients,
      );
      return response['success'] == true;
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> removePatient(String id) async {
    try {
      final response = await _apiService.deleteApiWithToken(
       '${AppUrl.deletePatients}/$id',
      );
      return response['success'] == true;
    } catch (e) {
      rethrow;
    }
  }
  //book appointments api
  Future<bool> bookAppointment({
    required String patientId,
    required var isEmergency,
    required String vendorId,
    required String appointmentDate,
    required String timeSlot,
    required String type,
    required String categoryId,
    required List<String> reminders,
    String notes = "",
  }) async {
    final body = {
      "patientId": patientId,
      "vendorId": vendorId,
      "isEmergency": isEmergency,
      "appointmentDate": appointmentDate,
      "timeSlot": timeSlot,
      "reminder": reminders,
      "type": type,
      "notes": notes,
      "category": categoryId,
    };

    try {
      final response = await _apiService.postApiWithToken(
        body,
        AppUrl.createBooking,
      );
      return response['success'] == true;
    } catch (e) {
      rethrow;
    }
  }
}

