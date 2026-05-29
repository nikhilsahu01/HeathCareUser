import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/api_service/app_url.dart';

class RatingReviewViewModel extends ChangeNotifier {
  bool isLoading = false;

  Future<bool> submitAppRating({
    required double rating,
    required String review,
  }) async {
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

      var response = await http.post(
        Uri.parse(AppUrl.appRating),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'rating': rating,
          'review': review,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        debugPrint("Rating Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      debugPrint("Rating Exception: $e");
    }

    isLoading = false;
    notifyListeners();
    return false;
  }
}
