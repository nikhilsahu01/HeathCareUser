class CmsDataMode {
  bool? status;
  String? message;
  List<Data>? data;

  CmsDataMode({this.status, this.message, this.data});

  CmsDataMode.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? sId;
  String? termCondition;
  String? privacyPolicy;
  String? type;
  String? aboutUs;
  int? iV;

  Data(
      {this.sId,
        this.termCondition,
        this.privacyPolicy,
        this.type,
        this.aboutUs,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    termCondition = json['term_condition'];
    privacyPolicy = json['privacy_policy'];
    type = json['type'];
    aboutUs = json['about_us'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['term_condition'] = this.termCondition;
    data['privacy_policy'] = this.privacyPolicy;
    data['type'] = this.type;
    data['about_us'] = this.aboutUs;
    data['__v'] = this.iV;
    return data;
  }
}