class AddressModel {
  bool? success;
  String? message;
  List<HomeAddressData>? data;

  AddressModel({this.success, this.message, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HomeAddressData>[];
      json['data'].forEach((v) {
        data!.add(new HomeAddressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeAddressData {
  String? sId;
  String? userId;
  String? floor;
  String? mobileNumber;
  String? addressLine1;
  String? addressLine2;
  String? landmark;
  String? city;
  String? state;
  String? country;
  String? pincode;
  double? latitude;
  double? longitude;
  String? addressType;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;
  int? iV;

  HomeAddressData(
      {this.sId,
        this.userId,
        this.floor,
        this.mobileNumber,
        this.addressLine1,
        this.addressLine2,
        this.landmark,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.latitude,
        this.longitude,
        this.addressType,
        this.isDefault,
        this.createdAt,
        this.updatedAt,
        this.iV});

  HomeAddressData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    floor = json['floor'];
    mobileNumber = json['mobileNumber'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressType = json['addressType'];
    isDefault = json['isDefault'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['floor'] = this.floor;
    data['mobileNumber'] = this.mobileNumber;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['landmark'] = this.landmark;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['addressType'] = this.addressType;
    data['isDefault'] = this.isDefault;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}