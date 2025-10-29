


import 'package:flutter/material.dart';
import 'package:health_care/screens/all_health_issues_list/model/health_issues_model.dart';

import '../repo/health_issues_repo.dart';

class AllHealthIssuesListViewmodel extends ChangeNotifier {
  final AllHealthIssuesListRepository _repository = AllHealthIssuesListRepository();

  bool _isLoading = false;
  List<Symptoms> _allSymptoms = [];
  String _searchQuery = '';

  bool get isLoading => _isLoading;

  List<Symptoms> get categories {
    if (_searchQuery.isEmpty) return _allSymptoms;
    return _allSymptoms
        .where((symptom) => symptom.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
        .toList();
  }

  Future<void> fetchSymptoms() async {
    _isLoading = true;
    notifyListeners();

    try {
      final model = await _repository.getAllHealthIssuesListApi();
      _allSymptoms = model.data?.symptoms ?? [];
    } catch (e) {
      debugPrint("❌ Error fetching symptoms: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }
}



