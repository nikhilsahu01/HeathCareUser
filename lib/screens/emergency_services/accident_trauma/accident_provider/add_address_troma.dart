
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:health_care/screens/emergency_services/model/add_address_manually_model_troma.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../home/view/bottom_controller.dart';
import '../../repo/emergency_repo.dart';
import 'package:geolocator/geolocator.dart';

class TromaAddAddressManuallyProvider extends ChangeNotifier {
  // Address fields (hardcoded values for now - replace with actual input if needed)
  final addressController = TextEditingController();
  final floorController = TextEditingController();
  final houseController = TextEditingController();
  final landmarkController = TextEditingController();
  final receiverNameController = TextEditingController();
  final receiverNumberController = TextEditingController();
  final dateController = TextEditingController();
  final timeslotController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  // Emergency form fields
  final patientNameController = TextEditingController();
  final mobilenumberController = TextEditingController();
  final patientAge = TextEditingController();
  final dropController = TextEditingController();

  final repo = EmergencyServicesRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TraumaAddressModel? addNewAddressModelTroma;
  String? _error;
  String? get error => _error;

  bool conscious = true; // default
  bool breathing = true; // default
  String gender = "Male"; // default
  String landmark = "";
  void setConsciousType(String value) {
    conscious = (value == "Yes");
    notifyListeners();
  }

  void setBreathingType(String value) {
    breathing = (value == "Yes");
    notifyListeners();
  }

  void setGenderFor(String value) {
    gender = value;
    notifyListeners();
  }

  /// ✅ Function to get current location (latitude & longitude)
  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        _error = "Location permission denied";
        notifyListeners();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitudeController.text = position.latitude.toString();
      longitudeController.text = position.longitude.toString();

      print("📍 Current Location: ${position.latitude}, ${position.longitude}");

      // ✅ Reverse geocoding to get landmark
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        landmark = place.street ?? ""; // street/nearby landmark
        print("📍 Landmark (reverse geocode): $landmark");
      }

      notifyListeners();
    } catch (e) {
      _error = "Failed to get location: $e";
      print(_error);
      notifyListeners();
    }
  }

  /// ✅ Submit Accidental Trauma Booking
  Future<void> createAccidentalTraumaBooking({
    required BuildContext context,
    required String addressType,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      var data2 = {
        "isAccidentalTrauma": true,
        "location": {
          "type": "Point",
          "coordinates": [
            double.tryParse(latitudeController.text.trim()) ?? 0.0,
            double.tryParse(longitudeController.text.trim()) ?? 0.0,
          ]
        },
        "address_type": addressType, // Dynamic from screen
        "address_details": {
          "floor": floorController.text.trim().isNotEmpty ? floorController.text.trim() : " ",
          "house_number": houseController.text.trim().isNotEmpty ? houseController.text.trim() : " ",
          "landMark": landmark.isNotEmpty ? landmark : " ",
          "receiver_name": receiverNameController.text.trim().isNotEmpty ? receiverNameController.text.trim() : " ",
          "receiver_number": receiverNumberController.text.trim().isNotEmpty ? receiverNumberController.text.trim() : " ",
        },
        "emergency_form": {
          "patient_name": patientNameController.text.trim(),
          "patient_age": patientAge.text.trim(),
          "gender": gender,
          "is_conscious": conscious,
          "is_breathing": breathing
        },
      };

      final response = await repo.postAccidentalTraumaApi(data2);
      addNewAddressModelTroma = response;

      if (response.success == true) {
        clearForm();
        navPushRemove(context: context, page: BottomNavController());
      } else {
        HelperMethods.showFloatingToast(context, message: 'Something went wrong!');
      }
    } catch (e) {
      print(e.toString());
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
  void clearForm() {
    patientNameController.clear();
    patientAge.clear();
    mobilenumberController.clear();
    dropController.clear();
    addressController.clear();
    floorController.clear();
    houseController.clear();
    landmarkController.clear();
    receiverNameController.clear();
    receiverNumberController.clear();
    latitudeController.clear();
    longitudeController.clear();

    gender = "Male";
    conscious = true;
    breathing = true;

    notifyListeners();
  }
}
