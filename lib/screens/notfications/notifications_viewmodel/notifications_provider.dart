import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/notifications_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api_service/app_url.dart';

class NotificationProvider extends ChangeNotifier {
  bool loading = false;
  NotificationModel? notificationModel;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> getNotification({required BuildContext context}) async {
    setLoading(true);
    
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      
      if (token != null) {
        final response = await http.get(
          Uri.parse(AppUrl.getNotificationsList),
          headers: {'Authorization': 'Bearer $token'},
        );
        
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          
          List<NotificationData> listData = [];
          if (json['data'] != null && json['data']['list'] != null) {
            for (var item in json['data']['list']) {
              listData.add(NotificationData(
                id: item['_id'] ?? item['id'] ?? 0, 
                title: item['title'] ?? 'Notification',
                message: item['body'] ?? item['message'] ?? '',
                createdAt: item['createdAt'] ?? DateTime.now().toIso8601String(),
              ));
            }
          }
          
          notificationModel = NotificationModel(
            status: json['status'] ?? true,
            data: listData,
          );
        } else {
          // If API fails, you could set an empty model or show error
          notificationModel = NotificationModel(status: false, data: []);
        }
      }
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
      notificationModel = NotificationModel(status: false, data: []);
    }

    setLoading(false);
  }
}
