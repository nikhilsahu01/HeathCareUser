import 'package:flutter/material.dart';

import '../model/cms_model.dart';
import '../repo/cms_repo.dart';

class CmsViewModel extends ChangeNotifier {

  final CmsRepo _repo = CmsRepo();

  bool isLoading = false;

  CmsDataMode? cmsModel;

  Future<void> getCmsData() async {

    isLoading = true;
    notifyListeners();

    try {

      final response = await _repo.getCmsData();

      cmsModel = CmsDataMode.fromJson(response);

    } catch (e) {

      debugPrint("CMS ERROR === $e");

    } finally {

      isLoading = false;
      notifyListeners();
    }
  }
}