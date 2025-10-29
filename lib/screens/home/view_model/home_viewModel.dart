import 'package:flutter/material.dart';

import '../model/home_model.dart';
import '../repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepository();
  HomeDataModel? _homeDataModel;
  bool _isLoading = false;
  String? _errorMessage;

  HomeDataModel? get homeDataModel => _homeDataModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchHomeData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _homeDataModel = await _homeRepository.getProfileApi();
    } catch (e) {
      _errorMessage = 'Failed to load data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}