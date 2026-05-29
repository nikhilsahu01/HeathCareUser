import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api_service/app_url.dart';

class HelpCenterViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> faqs = [];

  Future<void> fetchHelpCenterData() async {
    isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var response = await http.get(
        Uri.parse(AppUrl.helpCenter),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          faqs = data['data'];
        }
      }
    } catch (e) {
      debugPrint("Help Center Fetch Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
