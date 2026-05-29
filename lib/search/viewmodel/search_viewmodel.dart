import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/api_service/app_url.dart';

/// ===========================
/// MODEL
/// ===========================

class SearchResultItem {
  final String type;
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String screen;

  SearchResultItem({
    required this.type,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.screen,
  });

  factory SearchResultItem.fromJson(Map<String, dynamic> json) {
    String sub = json['subtitle'] ?? '';
    if (sub.startsWith('[')) {
      try {
        List<dynamic> parsed = jsonDecode(sub);
        sub = parsed.join(', ');
      } catch (e) {}
    }
    return SearchResultItem(
      type: json['type'] ?? '',
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: sub,
      image: json['image'] ?? '',
      screen: json['screen'] ?? '',
    );
  }
}

/// ===========================
/// VIEW MODEL
/// ===========================

class SearchViewModel extends ChangeNotifier {

  List<SearchResultItem> _searchResults = [];

  bool _isLoading = false;

  List<SearchResultItem> get searchResults => _searchResults;

  bool get isLoading => _isLoading;

  SearchViewModel();

  /// ===========================
  /// SEARCH FUNCTION
  /// ===========================

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final url = '${AppUrl.baseUrl}/api/user/search?q=$query';
      print("🔎 SEARCH API REQUEST: GET $url");
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      
      print("🔎 SEARCH API RESPONSE CODE: ${response.statusCode}");
      print("🔎 SEARCH API RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null && data['data']['results'] != null) {
          final resultsList = data['data']['results'] as List;
          _searchResults = resultsList.map((e) => SearchResultItem.fromJson(e)).toList();
        } else {
          _searchResults = [];
        }
      } else {
        print("🔎 SEARCH API ERROR: Failed to load results");
        _searchResults = [];
      }
    } catch (e) {
      print("🔎 SEARCH API EXCEPTION: $e");
      _searchResults = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}