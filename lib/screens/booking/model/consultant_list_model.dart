
class ConsultantListModel {
  bool? status;
  String? message;
  List<ConsultantListData>? data;

  ConsultantListModel({this.status, this.message, this.data});

  ConsultantListModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ConsultantListData>[];
      json['data'].forEach((v) {
        data!.add(new ConsultantListData.fromJson(v));
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

class ConsultantListData {
  String? sId;
  String? name;
  String? address;
  List<String>? department;
  String? yearOfExp;
  String? inClinicFee;
  String? profileImage;
  String? videoConsultFee;

  ConsultantListData(
      {this.sId,
        this.name,
        this.address,
        this.department,
        this.yearOfExp,
        this.inClinicFee,
        this.profileImage,
        this.videoConsultFee});

  ConsultantListData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['Name'];
    address = json['address'];
    department = json['department'].cast<String>();
    yearOfExp = json['yearOfExp'];
    inClinicFee = json['inClinicFee'];
    profileImage = json['profileImage'];
    videoConsultFee = json['videoConsultFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['address'] = this.address;
    data['department'] = this.department;
    data['yearOfExp'] = this.yearOfExp;
    data['inClinicFee'] = this.inClinicFee;
    data['profileImage'] = this.profileImage;
    data['videoConsultFee'] = this.videoConsultFee;
    return data;
  }
}