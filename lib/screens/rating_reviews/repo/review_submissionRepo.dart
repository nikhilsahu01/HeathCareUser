import 'package:flutter/material.dart';
import '../../../core/api_service/app_url.dart';
import '../../../core/api_service/network_api_service.dart';


// class ReviewSubmission {
//   final _apiService = NetworkApiServices();
//
//
//
//   Future<bool> submitReviews({
//     required String appointmentId,
//     required String rating,
//     required String review,
//   }) async {
//     final body = {
//       "appointmentId": appointmentId,
//       "rating": rating,
//       "review": review,
//     };
//     final url = AppUrl.createReviews;
//     try {
//       final response = await _apiService.postApiWithToken(body, url);
//       debugPrint("✅ Response: $response");
//       return response['success'] == true;
//     } catch (e) {
//       debugPrint("❌ Exception during createAppointment request: $e");
//       rethrow;
//     }
//   }
// }
//
class ReviewSubmission {
  final _apiService = NetworkApiServices();

  Future<Map<String, dynamic>> submitReviews({
    required String appointmentId,
    required String rating,
    required String review,
  }) async {
    final body = {
      "appointmentId": appointmentId,
      "rating": rating,
      "review": review,
    };
    final url = AppUrl.createReviews;
    try {
      final response = await _apiService.postApiWithToken(body, url);
      debugPrint("✅ Response: $response");
      return response; // Return the full response
    } catch (e) {
      debugPrint("❌ Exception during createAppointment request: $e");
      rethrow; // Rethrow the exception for further handling
    }
  }
}