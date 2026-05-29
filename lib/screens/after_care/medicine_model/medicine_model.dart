class MedicineModel {
  String? id;
  String? medicineName;
  String? dosage;
  String? timing;
  bool? isTaken;

  MedicineModel({
    this.id,
    this.medicineName,
    this.dosage,
    this.timing,
    this.isTaken,
  });

  MedicineModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    medicineName = json['medicineName'];
    dosage = json['dosage'];
    timing = json['timing'];
    isTaken = json['isTaken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.id;
    data['medicineName'] = this.medicineName;
    data['dosage'] = this.dosage;
    data['timing'] = this.timing;
    data['isTaken'] = this.isTaken;
    return data;
  }
}