import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/category_list_model.dart';
import '../repo/booking_repository.dart';

class SpecialisationsViewModel extends ChangeNotifier {
  final BookingRepository _repository = BookingRepository();

  CategoryListModel? _categoryListModel;
  CategoryListModel? get categoryListModel => _categoryListModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> fetchSpecialisationData(List<String> symptomIds) async {
    _isLoading = true;
    notifyListeners();

    try {
      _categoryListModel = await _repository.getCategoryListApi(symptomIds);
    } catch (e) {
      debugPrint('❌ Error fetching specialisations: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Data> get filteredCategories {
    final List<Data>? originalList = _categoryListModel?.data;
    if (originalList == null) return [];

    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return originalList;

    return originalList.where((category) {
      final name = category.name?.toLowerCase() ?? '';
      final id = category.sId?.toLowerCase() ?? '';
      return name.contains(query) || id == query;
    }).toList();
  }
}

