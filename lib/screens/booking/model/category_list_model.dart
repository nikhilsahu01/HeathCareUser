class CategoryListModel {
  bool? status;
  String? message;
  List<Data>? data;

  CategoryListModel({this.status, this.message, this.data});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
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
  String? name;
  String? image;
  List<String>? matchedSymptoms;
  int? matchCount;

  Data(
      {this.sId, this.name, this.image, this.matchedSymptoms, this.matchCount});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    matchedSymptoms = json['matchedSymptoms'].cast<String>();
    matchCount = json['matchCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['matchedSymptoms'] = this.matchedSymptoms;
    data['matchCount'] = this.matchCount;
    return data;
  }
}