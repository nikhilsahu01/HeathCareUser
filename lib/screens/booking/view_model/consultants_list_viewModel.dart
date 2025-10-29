// view_model/doctors_view_model.dart

import 'package:flutter/material.dart';

import '../model/consultant_list_model.dart';
import '../repo/booking_repository.dart';


class ConsultantListViewModel extends ChangeNotifier {
  final BookingRepository _repository = BookingRepository();

  ConsultantListModel? _consultantListModel;
  List<ConsultantListData> _allDoctors = [];
  List<ConsultantListData> _filteredDoctors = [];
  bool _isLoading = false;

  List<ConsultantListData> get doctors => _filteredDoctors;
  bool get isLoading => _isLoading;

  Future<void> fetchDoctors(String categoryId, String categoryType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final model = await _repository.getConsultantListApi(categoryId, categoryType);
      _consultantListModel = model;
      _allDoctors = model.data ?? [];
      _filteredDoctors = _allDoctors; // Show all initially
    } catch (e) {
      debugPrint("❌ Error fetching doctors: $e");
      _allDoctors = [];
      _filteredDoctors = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterDoctors(String query) {
    if (query.isEmpty) {
      _filteredDoctors = _allDoctors;
    } else {
      _filteredDoctors = _allDoctors.where((doctor) {
        final name = doctor.name?.toLowerCase() ?? '';
        final dept = (doctor.department ?? []).join(' ').toLowerCase();
        return name.contains(query.toLowerCase()) || dept.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
