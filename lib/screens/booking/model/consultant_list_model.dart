//
// class ConsultantListModel {
//   bool? status;
//   String? message;
//   List<ConsultantListData>? data;
//
//   ConsultantListModel({this.status, this.message, this.data});
//
//   ConsultantListModel.fromJson(Map<String, dynamic> json) {
//     status = json['success'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <ConsultantListData>[];
//       json['data'].forEach((v) {
//         data!.add(new ConsultantListData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ConsultantListData {
//   String? sId;
//   String? name;
//   String? address;
//   List<String>? department;
//   String? yearOfExp;
//   String? inClinicFee;
//   String? profileImage;
//   String? videoConsultFee;
//
//   ConsultantListData(
//       {this.sId,
//         this.name,
//         this.address,
//         this.department,
//         this.yearOfExp,
//         this.inClinicFee,
//         this.profileImage,
//         this.videoConsultFee});
//
//   ConsultantListData.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['Name'];
//     address = json['address'];
//     department = json['department'].cast<String>();
//     yearOfExp = json['yearOfExp'];
//     inClinicFee = json['inClinicFee'];
//     profileImage = json['profileImage'];
//     videoConsultFee = json['videoConsultFee'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['Name'] = this.name;
//     data['address'] = this.address;
//     data['department'] = this.department;
//     data['yearOfExp'] = this.yearOfExp;
//     data['inClinicFee'] = this.inClinicFee;
//     data['profileImage'] = this.profileImage;
//     data['videoConsultFee'] = this.videoConsultFee;
//     return data;
//   }
// }



class ConsultantListModel {
  bool? success;
  String? message;
  Data? data;

  ConsultantListModel({
    this.success,
    this.message,
    this.data,
  });

  ConsultantListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};

    dataMap['success'] = success;
    dataMap['message'] = message;

    if (data != null) {
      dataMap['data'] = data!.toJson();
    }

    return dataMap;
  }
}

class Data {
  List<ConsultantListData>? doctors;
  Meta? meta;

  Data({
    this.doctors,
    this.meta,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = <ConsultantListData>[];
      json['doctors'].forEach((v) {
        doctors!.add(ConsultantListData.fromJson(v));
      });
    }

    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};

    if (doctors != null) {
      dataMap['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }

    if (meta != null) {
      dataMap['meta'] = meta!.toJson();
    }

    return dataMap;
  }
}

class ConsultantListData {
  String? sId;
  Category? category;
  String? name;
  String? address;
  List<String>? department;
  String? yearOfExp;
  String? inClinicFee;
  String? videoConsultFee;
  String? profileImage;
  String? country;
  String? doctorRegion;
  String? role;

  ConsultantListData({
    this.sId,
    this.category,
    this.name,
    this.address,
    this.department,
    this.yearOfExp,
    this.inClinicFee,
    this.videoConsultFee,
    this.profileImage,
    this.country,
    this.doctorRegion,
    this.role,
  });

  ConsultantListData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];

    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;

    name = json['Name'];
    address = json['address'];

    if (json['department'] != null) {
      department = List<String>.from(json['department']);
    }

    yearOfExp = json['yearOfExp'];
    inClinicFee = json['inClinicFee'];
    videoConsultFee = json['videoConsultFee'];
    profileImage = json['profileImage'];
    country = json['country'];
    doctorRegion = json['doctorRegion'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};

    dataMap['_id'] = sId;

    if (category != null) {
      dataMap['category'] = category!.toJson();
    }

    dataMap['Name'] = name;
    dataMap['address'] = address;
    dataMap['department'] = department;
    dataMap['yearOfExp'] = yearOfExp;
    dataMap['inClinicFee'] = inClinicFee;
    dataMap['videoConsultFee'] = videoConsultFee;
    dataMap['profileImage'] = profileImage;
    dataMap['country'] = country;
    dataMap['doctorRegion'] = doctorRegion;
    dataMap['role'] = role;

    return dataMap;
  }
}

class Category {
  String? sId;
  String? name;

  Category({
    this.sId,
    this.name,
  });

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};

    dataMap['_id'] = sId;
    dataMap['name'] = name;

    return dataMap;
  }
}

class Meta {
  String? userCountry;
  bool? windowMode;
  dynamic primaryDoctorId;

  Meta({
    this.userCountry,
    this.windowMode,
    this.primaryDoctorId,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    userCountry = json['userCountry'];
    windowMode = json['windowMode'];
    primaryDoctorId = json['primaryDoctorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};

    dataMap['userCountry'] = userCountry;
    dataMap['windowMode'] = windowMode;
    dataMap['primaryDoctorId'] = primaryDoctorId;

    return dataMap;
  }
}