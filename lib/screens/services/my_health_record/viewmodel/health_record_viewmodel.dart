import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/api_service/app_url.dart';

class HealthRecordViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> healthRecords = [];
  List<dynamic> prescriptions = [];

  Future<void> fetchHealthRecords() async {
    isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        final response = await http.get(
          Uri.parse(AppUrl.getHealthRecords),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          healthRecords = json['data']?['documents'] ?? [];
          prescriptions = json['data']?['prescriptions'] ?? [];
        }
      }
    } catch (e) {
      debugPrint("Fetch Health Records Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> uploadHealthRecord(String filePath, String title) async {
    isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        isLoading = false;
        notifyListeners();
        return false;
      }

      var request = http.MultipartRequest('POST', Uri.parse(AppUrl.uploadHealthRecord));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['title'] = title;

      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchHealthRecords(); // Refresh the list
        return true;
      } else {
        debugPrint("Health Record Upload failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Health Record Upload Error: $e");
    }

    isLoading = false;
    notifyListeners();
    return false;
  }
}
