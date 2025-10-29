import 'package:flutter/material.dart';
import '../model/all_categories_model.dart';
import '../repo/repo.dart';



class CategoriesListViewmodel extends ChangeNotifier {
  final CategoriesListRepository _repository = CategoriesListRepository();

  bool _isLoading = false;
  List<Categories> _categories = [];
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  List<Categories> get categories {
    if (_searchQuery.isEmpty) return _categories;
    return _categories
        .where((cat) => (cat.name ?? '').toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final model = await _repository.getCategoriesListApi();
      _categories = model.data?.categories ?? [];
    } catch (e) {
      debugPrint("❌ Error fetching categories: $e");
      _categories = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}


