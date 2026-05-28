class SearchModel {
  final String type;
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String screen;
  final SearchMeta meta;

  SearchModel({
    required this.type,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.screen,
    required this.meta,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      type: json['type'] ?? '',
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      image: json['image'] ?? '',
      screen: json['screen'] ?? '',
      meta: SearchMeta.fromJson(json['meta'] ?? {}),
    );
  }
}

class SearchMeta {
  final String yearOfExp;
  final String inClinicFee;
  final String videoConsultFee;
  final double rating;

  SearchMeta({
    required this.yearOfExp,
    required this.inClinicFee,
    required this.videoConsultFee,
    required this.rating,
  });

  factory SearchMeta.fromJson(Map<String, dynamic> json) {
    return SearchMeta(
      yearOfExp: json['yearOfExp']?.toString() ?? '',
      inClinicFee: json['inClinicFee']?.toString() ?? '',
      videoConsultFee: json['videoConsultFee']?.toString() ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}