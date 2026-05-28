import 'dart:io';
import 'package:flutter/material.dart';
import '../model/profile_model.dart';
import '../repository/profile_repo.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepo _repo = ProfileRepo();

  ProfileUser? _profileUser;
  bool _isLoading = false;

  ProfileUser? get profileUser => _profileUser;
  bool get isLoading => _isLoading;

  // Controllers for Personal Details
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? gender;
  String? status;
  File? profileImageFile; // If user selects a new profile image

  /// Fetch Profile Data
  Future<void> fetchProfile() async {
    _isLoading = true;
    notifyListeners();
    try {
      _profileUser = await _repo.getProfileApi();
      if (_profileUser?.user != null) {
        _setControllersFromUser(_profileUser!.user!);
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Set controllers from API user data
  void _setControllersFromUser(User user) {
    nameController.text = user.name ?? "";
    mobileController.text = user.mobileNo ?? "";
    emailController.text = user.email ?? "";
    dobController.text = user.createdAt ?? ""; //todo
    bloodGroupController.text = user.bloodGroup ?? "";
    maritalStatusController.text = user.maritalStatus ?? "";
    // locationController.text = user.address ?? "";
    heightController.text = 'height';
    weightController.text = 'weight';
    if (user.gender == null || user.gender!.isEmpty) {
      gender = "Please Select Your gender";
    } else if (user.gender!.toLowerCase() == 'male') {
      gender = "Male";
    } else if (user.gender!.toLowerCase() == 'female') {
      gender = "Female";
    } else if (user.gender!.toLowerCase() == 'other') {
      gender = "Other";
    } else {
      gender = "Please Select Your gender"; // fallback to hint if unknown
    }

    // height/weight might be separate in medical model, fill when available
  }

  /// Update Profile
  // Future<void> updateProfile() async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     Map<String, String> fields = {
  //       "name": nameController.text,
  //       "mobileNo": mobileController.text,
  //       "gender": (gender ?? "").toLowerCase(),
  //       "bloodGroup": bloodGroupController.text,
  //       "maritalStatus": maritalStatusController.text,
  //       "address": locationController.text,
  //       "height":heightController.text,
  //       "weight":weightController.text,
  //       // dob/height/weight -> add when your backend supports them
  //     };
  //
  //     Map<String, File> files = {};
  //     if (profileImageFile != null) {
  //       files["profileImage"] = profileImageFile!;
  //     }
  //
  //     _profileUser = await _repo.updateProfileApi(
  //       fields: fields,
  //       files: files,
  //     );
  //
  //     if (_profileUser?.user != null) {
  //       _setControllersFromUser(_profileUser!.user!);
  //     }
  //   } catch (e) {
  //     debugPrint("Error updating profile: $e");
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> updateProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      Map<String, String> fields = {
        "name": nameController.text,
        "mobileNo": mobileController.text,
        "gender": (gender ?? "").toLowerCase(),
        "bloodGroup": "A+",
        "maritalStatus": "single",
        "address": locationController.text,
        "height":heightController.text,
        "weight":weightController.text,
        // dob/height/weight -> add when your backend supports them
      };

      Map<String, File> files = {};
      if (profileImageFile != null) {
        files["profileImage"] = profileImageFile!;
      }

      _profileUser = await _repo.updateProfileApi(
        fields: fields,
        files: files,
      );

      if (_profileUser?.user != null) {
        _setControllersFromUser(_profileUser!.user!);
      }
    } catch (e) {
      debugPrint("Error updating profile: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    dobController.dispose();
    bloodGroupController.dispose();
    maritalStatusController.dispose();
    heightController.dispose();
    weightController.dispose();
    locationController.dispose();
    super.dispose();
  }
}
