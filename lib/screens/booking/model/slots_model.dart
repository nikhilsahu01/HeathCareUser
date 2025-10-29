class ReminderSlotsModel {
  bool? status;
  String? message;
  ReminderSlotsData? data;

  ReminderSlotsModel({this.status, this.message, this.data});

  ReminderSlotsModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ReminderSlotsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ReminderSlotsData {
  List<String>? reminderSlots;

  ReminderSlotsData({this.reminderSlots});

  ReminderSlotsData.fromJson(Map<String, dynamic> json) {
    reminderSlots = json['reminderSlots'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reminderSlots'] = this.reminderSlots;
    return data;
  }
}


class AvailableSlotsModel {
  bool? status;
  String? message;
  List<AvailableSlotsData>? data;

  AvailableSlotsModel({this.status, this.message, this.data});

  AvailableSlotsModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AvailableSlotsData>[];
      json['data'].forEach((v) {
        data!.add(new AvailableSlotsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableSlotsData {
  String? start;
  String? end;
  String? status;

  AvailableSlotsData({this.start, this.end, this.status});

  AvailableSlotsData.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    status = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    data['status'] = this.status;
    return data;
  }
}