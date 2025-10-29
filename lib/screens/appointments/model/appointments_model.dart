class AppointmentsListModel {
  bool? status;
  String? message;
  Data? data;

  AppointmentsListModel({this.status, this.message, this.data});

  AppointmentsListModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<AppointmentsList>? appointments;
  Pagination? pagination;

  Data({this.appointments, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      appointments = <AppointmentsList>[];
      json['data'].forEach((v) {
        appointments!.add(AppointmentsList.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.appointments != null) {
      data['data'] = this.appointments!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class AppointmentsList {
  String? sId;
  String? user;
  String? patient;
  Vendor? vendor;
  Category? category;
  String? appointmentDate;
  String? timeSlot;
  List<String>? reminder;
  String? type;
  String? isReminder;
  String? status;
  String? notes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AppointmentsList({
    this.sId,
    this.user,
    this.patient,
    this.vendor,
    this.category,
    this.appointmentDate,
    this.timeSlot,
    this.reminder,
    this.type,
    this.isReminder,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  AppointmentsList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    patient = json['patient'];
    vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    appointmentDate = json['appointmentDate'];
    timeSlot = json['timeSlot'];
    reminder = json['reminder']?.cast<String>();
    type = json['type'];
    isReminder = json['isReminder'];
    status = json['success'];
    notes = json['notes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['patient'] = this.patient;
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['appointmentDate'] = this.appointmentDate;
    data['timeSlot'] = this.timeSlot;
    data['reminder'] = this.reminder;
    data['type'] = this.type;
    data['isReminder'] = this.isReminder;
    data['status'] = this.status;
    data['notes'] = this.notes;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Vendor {
  String? sId;
  String? name;
  String? profileImage;

  Vendor({this.sId, this.name});

  Vendor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['Name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class Category {
  String? sId;
  String? name;

  Category({this.sId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalResults;

  Pagination({this.currentPage, this.totalPages, this.totalResults});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['totalResults'] = this.totalResults;
    return data;
  }
}