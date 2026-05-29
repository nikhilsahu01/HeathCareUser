import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api_service/app_url.dart';
import '../medicine_model/medicine_model.dart';

class AftercareViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> aftercareAppointments = [];
  List<dynamic> instructions = [];
  List<MedicineModel> medicines = [];
  String? errorMessage;

  Future<void> fetchAftercareAppointments() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var response = await http.get(
        Uri.parse('${AppUrl.baseUrl}/api/user/aftercare/list'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          aftercareAppointments = data['data'];
        }
      } else {
        errorMessage = "Failed to load aftercare appointments";
      }
    } catch (e) {
      errorMessage = "Error fetching aftercare appointments: $e";
      debugPrint(errorMessage);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> cancelAftercare(String id) async {
    isLoading = true;
    notifyListeners();
    bool success = false;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var response = await http.post(
        Uri.parse('${AppUrl.baseUrl}/api/user/aftercare/cancel/$id'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"cancellReason": "User cancelled"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        success = true;
        // Refresh the list
        await fetchAftercareAppointments();
      }
    } catch (e) {
      debugPrint("Cancel Aftercare Error: $e");
    }

    isLoading = false;
    notifyListeners();
    return success;
  }

  /// MEDICINES
  Future<void> fetchMedicines() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var response = await http.get(
        Uri.parse('${AppUrl.baseUrl}/api/user/aftercare/medicine'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          medicines = (data['data'] as List).map((m) => MedicineModel.fromJson(m)).toList();
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Error fetching medicines: $e");
    }
  }

  Future<bool> addMedicine({
    required String name,
    required String dosage,
    required String timing,
  }) async {
    isLoading = true;
    notifyListeners();
    bool success = false;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var response = await http.post(
        Uri.parse('${AppUrl.baseUrl}/api/user/aftercare/medicine'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "medicineName": name,
          "dosage": dosage,
          "timing": timing
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        success = true;
        await fetchMedicines();
      }
    } catch (e) {
      debugPrint("Error adding medicine: $e");
    }

    isLoading = false;
    notifyListeners();
    return success;
  }

  Future<void> toggleMedicineStatus(String id, bool isTaken) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var response = await http.put(
        Uri.parse('${AppUrl.baseUrl}/api/user/aftercare/medicine/$id'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"isTaken": isTaken}),
      );

      if (response.statusCode == 200) {
        // Update local state for immediate feedback
        final index = medicines.indexWhere((m) => m.id == id);
        if (index != -1) {
          medicines[index].isTaken = isTaken;
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Error toggling medicine: $e");
    }
  }

  /// INSTRUCTIONS & HEALTH LOGS
  Future<void> fetchInstructions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var response = await http.get(
        Uri.parse('${AppUrl.baseUrl}/api/user/aftercare/instructions'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          instructions = data['data'];
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Error fetching instructions: $e");
    }
  }

  Future<bool> submitHealthLog({
    required int painLevel,
    required String bloodPressure,
    required int sugarLevel,
    required double temperature,
    required String symptoms,
    String? vendorId,
    String? appointmentId,
  }) async {
    isLoading = true;
    notifyListeners();
    bool success = false;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var response = await http.post(
        Uri.parse('${AppUrl.baseUrl}/api/user/aftercare/health-log'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "painLevel": painLevel,
          "bloodPressure": bloodPressure,
          "sugarLevel": sugarLevel,
          "temperature": temperature,
          "symptoms": symptoms,
          if (vendorId != null) "vendorId": vendorId,
          if (appointmentId != null) "appointmentId": appointmentId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        success = true;
      }
    } catch (e) {
      debugPrint("Error adding health log: $e");
    }

    isLoading = false;
    notifyListeners();
    return success;
  }
}
