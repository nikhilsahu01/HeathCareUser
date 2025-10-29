import 'package:flutter/material.dart';
import 'package:health_care/screens/booking/model/consultant_details_model.dart';

import '../repo/booking_repository.dart';


class ConsultantViewModel extends ChangeNotifier {
  final BookingRepository _repository = BookingRepository();

  ConsultantDetailsModel? _consultantDetailsModel;
  ConsultantDetailsData? get consultant => _consultantDetailsModel?.data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchConsultantDetails(String consultantId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _consultantDetailsModel = await _repository.getConsultantDetailsApi(consultantId);
    } catch (e) {
      debugPrint('❌ Error fetching consultant details: $e');
      _consultantDetailsModel = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
