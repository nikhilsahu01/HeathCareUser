class ConsultantDetailsModel {
  bool? status;
  String? message;
  ConsultantDetailsData? data;

  ConsultantDetailsModel({this.status, this.message, this.data});

  ConsultantDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    message = json['message'];
    data = json['data'] != null ? ConsultantDetailsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ConsultantDetailsData {
  String? sId;
  String? category;
  String? type;
  String? name;
  String? mobile;
  String? dob;
  String? gender;
  String? address;
  List<String>? department;
  List<String>? symptoms;
  String? qualification;
  String? yearOfExp;
  String? licOrRegNumber;
  String? certificate;
  String? state;
  String? district;
  String? pincode;
  String? lat;
  String? long;
  String? startTime;
  String? endTime;
  String? rating;
  int? commission;
  int? walletBalance;
  bool? isBlocked;
  String? agreementAccepted;
  bool? status;
  String? otpExpires;
  String? createdAt;
  int? iV;
  bool? isEmergency;
  bool? inClinicAvailable; // Corrected spelling
  bool? videoConsultAvailable;
  String? inClinicFee;
  String? profileImage;
  String? videoConsultFee;
  String? closingTime;
  String? openingTime;
  List<String>? selectDays; // Corrected from List<String> to List<String>
  int? breakTime;
  String? lunchEnd;
  String? lunchStart;
  int? sessionTime;
  String? totalPatient;
  String? review;

  ConsultantDetailsData({
    this.sId,
    this.category,
    this.type,
    this.name,
    this.mobile,
    this.dob,
    this.gender,
    this.address,
    this.department,
    this.symptoms,
    this.qualification,
    this.yearOfExp,
    this.licOrRegNumber,
    this.certificate,
    this.state,
    this.district,
    this.pincode,
    this.lat,
    this.long,
    this.startTime,
    this.endTime,
    this.rating,
    this.commission,
    this.walletBalance,
    this.isBlocked,
    this.agreementAccepted,
    this.status,
    this.otpExpires,
    this.createdAt,
    this.iV,
    this.isEmergency,
    this.inClinicAvailable,
    this.videoConsultAvailable,
    this.inClinicFee,
    this.profileImage,
    this.videoConsultFee,
    this.closingTime,
    this.openingTime,
    this.selectDays,
    this.breakTime,
    this.lunchEnd,
    this.lunchStart,
    this.sessionTime,
    this.totalPatient,
    this.review,
  });

  ConsultantDetailsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    type = json['type'];
    name = json['Name'];
    mobile = json['mobile'];
    dob = json['dob'];
    gender = json['gender'];
    address = json['address'];
    department = List<String>.from(json['department']);
    symptoms = List<String>.from(json['symptoms']); // Corrected to List<String>
    qualification = json['qualification'];
    yearOfExp = json['yearOfExp'];
    licOrRegNumber = json['licOrRegNumber'];
    certificate = json['certificate'];
    state = json['state'];
    district = json['district'];
    pincode = json['pincode'];
    lat = json['lat'];
    long = json['long'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    rating = json['rating'];
    commission = json['commission'];
    walletBalance = json['wallet_balance'];
    isBlocked = json['isBlocked'];
    agreementAccepted = json['agreementAccepted'];
    status = json['success'];
    otpExpires = json['otpExpires'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    isEmergency = json['isEmergency'];
    inClinicAvailable = json['inClinicAvaialble']; // Corrected spelling
    videoConsultAvailable = json['videoConsultAvailable'];
    inClinicFee = json['inClinicFee'];
    profileImage = json['profileImage'];
    videoConsultFee = json['videoConsultFee'];
    closingTime = json['closingTime'];
    openingTime = json['openingTime'];
    selectDays = List<String>.from(json['selectDays']); // Corrected to List<String>
    breakTime = json['breakTime'];
    lunchEnd = json['lunchEnd'];
    lunchStart = json['lunchStart'];
    sessionTime = json['sessionTime'];
    totalPatient = json['totalPatient'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['type'] = this.type;
    data['Name'] = this.name;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['department'] = this.department;
    data['symptoms'] = this.symptoms; // Corrected to symptoms
    data['qualification'] = this.qualification;
    data['yearOfExp'] = this.yearOfExp;
    data['licOrRegNumber'] = this.licOrRegNumber;
    data['certificate'] = this.certificate;
    data['state'] = this.state;
    data['district'] = this.district;
    data['pincode'] = this.pincode;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['rating'] = this.rating;
    data['commission'] = this.commission;
    data['wallet_balance'] = this.walletBalance;
    data['isBlocked'] = this.isBlocked;
    data['agreementAccepted'] = this.agreementAccepted;
    data['status'] = this.status;
    data['otpExpires'] = this.otpExpires;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['isEmergency'] = this.isEmergency;
    data['inClinicAvaialble'] = this.inClinicAvailable; // Corrected spelling
    data['videoConsultAvailable'] = this.videoConsultAvailable;
    data['inClinicFee'] = this.inClinicFee;
    data['profileImage'] = this.profileImage;
    data['videoConsultFee'] = this.videoConsultFee;
    data['closingTime'] = this.closingTime;
    data['openingTime'] = this.openingTime;
    data['selectDays'] = this.selectDays;
    data['breakTime'] = this.breakTime;
    data['lunchEnd'] = this.lunchEnd;
    data['lunchStart'] = this.lunchStart;
    data['sessionTime'] = this.sessionTime;
    data['totalPatient'] = this.totalPatient;
    data['review'] = this.review;
    return data;
  }
}