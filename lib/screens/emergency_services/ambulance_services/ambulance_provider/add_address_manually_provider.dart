
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/utils/global_variables.dart';
import '../../../../core/utils/helper_functions/helpers_methods.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../home/view/bottom_controller.dart';
import '../../model/add_address_manually_model.dart';
import '../../repo/emergency_repo.dart';



class AddAddressManuallyProvider extends ChangeNotifier {
  // ---------------- Address fields ----------------
  final addressController = TextEditingController(); // Home, Work, Other
  final floorController = TextEditingController();
  final houseController = TextEditingController();
  final landmarkController = TextEditingController();
  final receiverNameController = TextEditingController();
  final receiverNumberController = TextEditingController();

  // ---------------- Emergency fields ----------------
  final patientNameController = TextEditingController();
  final mobilenumberController = TextEditingController();
  final pickupController = TextEditingController();
  final dropController = TextEditingController();
  final dateController = TextEditingController();

  // ---------------- Location ----------------
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  double? _latitude;
  double? _longitude;
  String landmark = "";

  // ---------------- Time ----------------
  String selectedHour = '10';
  String selectedMinute = '30';
  String selectedPeriod = 'AM';

  // ---------------- State ----------------
  final repo = EmergencyServicesRepo();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AmbulanceAddressModel? addNewAddressModel;
  String? _error;
  String? get error => _error;

  // ---------------- Location ----------------

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

      _latitude = position.latitude;
      _longitude = position.longitude;

      latitudeController.text = _latitude.toString();
      longitudeController.text = _longitude.toString();

      // Reverse geocoding
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
print(position.latitude);
print('sdadk');
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        landmarkController.text = place.street ?? "";
      }

      notifyListeners();
    } catch (e) {
      _error = "Failed to get location: $e";
      notifyListeners();
    }
  }
  // ---------------- API ----------------
  Future<void> addNewAddress({required BuildContext context}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      var data = {
        "booking_type": bookingFor == 'bookingForNow' ? 'Now' : 'Later',
        "booking_for": isYourselfBooking == true ? 'Yourself' : 'Other',

        // Address
        "address_type": addressController.text.trim().isEmpty
            ? "Home"
            : addressController.text.trim(),
        "address_details": {
          "floor": floorController.text.trim(),
          "house_number": houseController.text.trim(),
          "landMark": landmarkController.text.trim(),
          "receiver_name": receiverNameController.text.trim(),
          "receiver_number": receiverNumberController.text.trim(),
        },

        // Emergency
        "date": dateController.text.trim(),
        "time_slot": "$selectedHour:$selectedMinute $selectedPeriod",
        "emergency_form": {
          "patient_name": patientNameController.text.trim(),
          "mobile_number": mobilenumberController.text.trim(),
          "pickup_address": pickupController.text.trim(),
          "drop_address": dropController.text.trim(),
        },

        // Location
        "location": {
          "type": "Point",
          "coordinates": [
            _latitude ?? 0.0,
            _longitude ?? 0.0,
          ]
        },

        "status": "Pending"
      };

      final response = await repo.postFullAddressApi(data);
      addNewAddressModel = response;

      if (response.success == true) {
        clearForm();
        navPushRemove(context: context, page: BottomNavController());
      } else {
        HelperMethods.showFloatingToast(context,
            message: 'Something went wrong!');
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // ---------------- Reset ----------------
  void clearForm() {
    // Address
    addressController.clear();
    floorController.clear();
    houseController.clear();
    landmarkController.clear();
    receiverNameController.clear();
    receiverNumberController.clear();

    // Emergency
    patientNameController.clear();
    mobilenumberController.clear();
    pickupController.clear();
    dropController.clear();
    dateController.clear();

    // Location
    latitudeController.clear();
    longitudeController.clear();

    notifyListeners();
  }
}
