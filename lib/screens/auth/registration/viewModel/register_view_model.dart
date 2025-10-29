import 'package:flutter/material.dart';
import '../repo/registration_repository.dart';




class RegistrationViewModel with ChangeNotifier {
  final RegistrationRepo _repo = RegistrationRepo();

  bool _isLoading = false;
  String? _error;


  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Add new
  Future<bool> addAddress({
    required BuildContext context,
    required String name,
    required String mobileNo,
    required String dob,
    required String gender,
    required String address,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _repo.registrationApi(
        name: name,
        mobileNo: mobileNo,
        dob: dob,
        gender: gender == 'Male'?'male' : gender == 'Female'? 'female' :'other',
        address: address,
      );

      if (success) {
        // (print sucess)
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = "Failed to Register";
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> welcome() async {
    try {
      await _repo.welcomeNotificationApi();
    } catch (e) {
      print("Error welcomeNotificationApi: $e");
    }
    notifyListeners();
  }
}
