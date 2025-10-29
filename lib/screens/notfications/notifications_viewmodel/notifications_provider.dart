import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/notifications_model.dart';

class NotificationProvider extends ChangeNotifier {
  bool loading = false;
  NotificationModel? notificationModel;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> getNotification({required BuildContext context}) async {
    setLoading(true);

    await Future.delayed(const Duration(seconds: 1)); // simulate API delay

    // ✅ Dummy data
    notificationModel = NotificationModel(
      status: true,
      data: [
        NotificationData(
          id: 1,
          title: "Appointment Confirmed",
          message: "New video consultation booked with Priya Sharma at 11:00 AM on June 5",
          createdAt: DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now().subtract(const Duration(minutes: 10))),
        ),
        NotificationData(
          id: 2,
          title: "Medicine Reminder",
          message: "Don’t forget to upload prescription for yesterday’s consultation with ballu Kapoor",
          createdAt: DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now().subtract(const Duration(hours: 3))),
        ),
        NotificationData(
          id: 3,
          title: "Health Tip",
          message: "Drink at least 2 liters of water daily for good health.",
          createdAt: DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now().subtract(const Duration(days: 1))),
        ),
      ],
    );

    setLoading(false);
  }
}
