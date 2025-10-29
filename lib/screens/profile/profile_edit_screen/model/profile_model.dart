class ProfileUser  {
  bool? success;
  User? user;

  ProfileUser ({this.success, this.user});

  ProfileUser .fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  Location? location;
  String? sId;
  String? name;
  String? mobileNo;
  String? gender;
  String? profileImage;
  String? address;
  String? userType;
  bool? status;
  bool? isVerified;
  String? lat;
  String? long;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastLogin;
  String? bloodGroup;
  String? maritalStatus;
  List<String>? deviceId;
  String? fcmToken;

  User({
    this.location,
    this.sId,
    this.name,
    this.mobileNo,
    this.gender,
    this.profileImage,
    this.address,
    this.userType,
    this.status,
    this.isVerified,
    this.lat,
    this.long,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.lastLogin,
    this.bloodGroup,
    this.maritalStatus,
    this.deviceId,
    this.fcmToken,
  });

  User.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
    profileImage = json['profileImage'];
    address = json['address'];
    userType = json['userType'];
    status = json['status'];
    isVerified = json['isVerified'];
    lat = json['lat'];
    long = json['long'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastLogin = json['lastLogin'];
    bloodGroup = json['bloodGroup'];
    maritalStatus = json['maritalStatus'];
    deviceId = List<String>.from(json['deviceId']);
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['gender'] = this.gender;
    data['profileImage'] = this.profileImage;
    data['address'] = this.address;
    data['userType'] = this.userType;
    data['status'] = this.status;
    data['isVerified'] = this.isVerified;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['lastLogin'] = this.lastLogin;
    data['bloodGroup'] = this.bloodGroup;
    data['maritalStatus'] = this.maritalStatus;
    data['deviceId'] = this.deviceId;
    data['fcmToken'] = this.fcmToken;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates; // Changed from List<Null> to List<double>

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['coordinates'] != null) {
      coordinates = List<double>.from(json['coordinates']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = this.type;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates;
    }
    return data;
  }
}