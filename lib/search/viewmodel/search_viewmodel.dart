import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ===========================
/// MODEL
/// ===========================

class SearchItem {
  final String title;
  final String subtitle;
  final IconData icon;

  SearchItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

/// ===========================
/// VIEW MODEL
/// ===========================

class SearchViewModel extends ChangeNotifier {

  final List<SearchItem> _allItems = [

    SearchItem(
      title: "Dr. Rahul Sharma",
      subtitle: "Cardiologist",
      icon: Icons.person,
    ),

    SearchItem(
      title: "Dr. Priya Singh",
      subtitle: "Dentist",
      icon: Icons.person,
    ),

    SearchItem(
      title: "Blood Test",
      subtitle: "Diagnostic Service",
      icon: Icons.medical_services,
    ),

    SearchItem(
      title: "MRI Scan",
      subtitle: "Radiology",
      icon: Icons.local_hospital,
    ),

    SearchItem(
      title: "Dr. Aman Verma",
      subtitle: "Neurologist",
      icon: Icons.person,
    ),

    SearchItem(
      title: "Skin Specialist",
      subtitle: "Dermatology",
      icon: Icons.face,
    ),
  ];

  List<SearchItem> _searchResults = [];

  bool _isLoading = false;

  List<SearchItem> get searchResults => _searchResults;

  bool get isLoading => _isLoading;

  SearchViewModel() {
    _searchResults = _allItems;
  }

  /// ===========================
  /// SEARCH FUNCTION
  /// ===========================

  Future<void> search(String query) async {

    _isLoading = true;
    notifyListeners();

    /// Fake API delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (query.trim().isEmpty) {

      _searchResults = _allItems;

    } else {

      final lowerQuery = query.toLowerCase();

      _searchResults = _allItems.where((item) {

        final title = item.title.toLowerCase();
        final subtitle = item.subtitle.toLowerCase();

        return title.contains(lowerQuery) ||
            subtitle.contains(lowerQuery);

      }).toList();
    }

    _isLoading = false;
    notifyListeners();
  }
}