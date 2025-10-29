class AmbulanceAddressModel {
  bool? success;
  String? message;
  Data? data;

  AmbulanceAddressModel({this.success, this.message, this.data});

  AmbulanceAddressModel.fromJson(Map<String, dynamic> json) {
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
  String? bookingType;
  String? bookingFor;
  String? addressType;
  AddressDetails? addressDetails;
  String? date;
  String? timeSlot;
  EmergencyForm? emergencyForm;
  Location? location;
  String? status;
  String? sId;
  int? iV;

  Data(
      {this.userId,
        this.bookingType,
        this.bookingFor,
        this.addressType,
        this.addressDetails,
        this.date,
        this.timeSlot,
        this.emergencyForm,
        this.location,
        this.status,
        this.sId,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    bookingType = json['booking_type'];
    bookingFor = json['booking_for'];
    addressType = json['address_type'];
    addressDetails = json['address_details'] != null
        ? new AddressDetails.fromJson(json['address_details'])
        : null;
    date = json['date'];
    timeSlot = json['time_slot'];
    emergencyForm = json['emergency_form'] != null
        ? new EmergencyForm.fromJson(json['emergency_form'])
        : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    status = json['status'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['booking_type'] = this.bookingType;
    data['booking_for'] = this.bookingFor;
    data['address_type'] = this.addressType;
    if (this.addressDetails != null) {
      data['address_details'] = this.addressDetails!.toJson();
    }
    data['date'] = this.date;
    data['time_slot'] = this.timeSlot;
    if (this.emergencyForm != null) {
      data['emergency_form'] = this.emergencyForm!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
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
  String? mobileNumber;
  String? pickupAddress;
  String? emergencyDetails;

  EmergencyForm({this.mobileNumber, this.pickupAddress, this.emergencyDetails});

  EmergencyForm.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobile_number'];
    pickupAddress = json['pickup_address'];
    emergencyDetails = json['emergency_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_number'] = this.mobileNumber;
    data['pickup_address'] = this.pickupAddress;
    data['emergency_details'] = this.emergencyDetails;
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
