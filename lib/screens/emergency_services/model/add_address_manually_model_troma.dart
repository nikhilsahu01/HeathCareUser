class TraumaAddressModel {
  bool? success;
  String? message;
  Data? data;

  TraumaAddressModel({this.success, this.message, this.data});

  TraumaAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  bool? isAccidentalTrauma;
  Location? location;
  String? addressType;
  AddressDetails? addressDetails;
  EmergencyForm? emergencyForm;
  String? status;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.userId,
        this.isAccidentalTrauma,
        this.location,
        this.addressType,
        this.addressDetails,
        this.emergencyForm,
        this.status,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    isAccidentalTrauma = json['isAccidentalTrauma'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    addressType = json['address_type'];
    addressDetails = json['address_details'] != null
        ? new AddressDetails.fromJson(json['address_details'])
        : null;
    emergencyForm = json['emergency_form'] != null
        ? new EmergencyForm.fromJson(json['emergency_form'])
        : null;
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['isAccidentalTrauma'] = this.isAccidentalTrauma;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['address_type'] = this.addressType;
    if (this.addressDetails != null) {
      data['address_details'] = this.addressDetails!.toJson();
    }
    if (this.emergencyForm != null) {
      data['emergency_form'] = this.emergencyForm!.toJson();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class AddressDetails {
  String? floor;
  String? houseNumber;
  String? landMark;
  String? receiverName;
  String? receiverNumber;

  AddressDetails(
      {this.floor,
        this.houseNumber,
        this.landMark,
        this.receiverName,
        this.receiverNumber});

  AddressDetails.fromJson(Map<String, dynamic> json) {
    floor = json['floor'];
    houseNumber = json['house_number'];
    landMark = json['landMark'];
    receiverName = json['receiver_name'];
    receiverNumber = json['receiver_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floor'] = this.floor;
    data['house_number'] = this.houseNumber;
    data['landMark'] = this.landMark;
    data['receiver_name'] = this.receiverName;
    data['receiver_number'] = this.receiverNumber;
    return data;
  }
}

class EmergencyForm {
  String? patientName;
  int? patientAge;
  String? gender;
  bool? isConscious;
  bool? isBreathing;

  EmergencyForm(
      {this.patientName,
        this.patientAge,
        this.gender,
        this.isConscious,
        this.isBreathing});

  EmergencyForm.fromJson(Map<String, dynamic> json) {
    patientName = json['patient_name'];
    patientAge = json['patient_age'];
    gender = json['gender'];
    isConscious = json['is_conscious'];
    isBreathing = json['is_breathing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_name'] = this.patientName;
    data['patient_age'] = this.patientAge;
    data['gender'] = this.gender;
    data['is_conscious'] = this.isConscious;
    data['is_breathing'] = this.isBreathing;
    return data;
  }
}