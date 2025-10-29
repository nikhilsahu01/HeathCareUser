class NotificationModel {
  bool? status;
  List<NotificationData>? data;

  NotificationModel({this.status, this.data});
}

class NotificationData {
  final int? id;
  final String? title;
  final String? message;
  final String? createdAt;

  NotificationData({this.id, this.title, this.message, this.createdAt});
}
