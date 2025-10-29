import 'package:flutter/material.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';

import 'address_model.dart';
import 'address_repo.dart';


class AddressViewModel with ChangeNotifier {
  final AddressReo _repo = AddressReo();

  bool _isLoading = false;
  String? _error;
  AddressModel? _addressModel;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<HomeAddressData> get addresses => _addressModel?.data ?? [];

  HomeAddressData? get defaultAddress =>
      addresses.firstWhere((a) => a.isDefault == true, orElse: () => addresses.isNotEmpty ? addresses.first : HomeAddressData());

  /// Fetch all addresses
  Future<void> fetchAddresses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _repo.getFullAddressApi();
      _addressModel = response;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Add new address
  Future<bool> addAddress({
    required BuildContext context,
    required String floor,
    required String mobileNumber,
    required String addressLine1,
    required String addressLine2,
    required String landmark,
    required String city,
    required String state,
    required String country,
    required String pincode,
    String? latitude,
    String? longitude,
    required String addressType,
    required bool isDefault,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _repo.createAddressApi(
        floor: floor,
        mobileNumber: mobileNumber,
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        landmark: landmark,
        city: city,
        state: state,
        country: country,
        pincode: pincode,
        latitude: latitude ?? '',
        longitude: longitude ?? '',
        addressType: addressType,
        isDefault: isDefault,
      );

      if (success) {
        await fetchAddresses();
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = "Failed to add address";
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }



  /// Update existing address
  Future<bool> updateAddress({
    required BuildContext context,
    required String id,
    required String floor,
    required String mobileNumber,
    required String addressLine1,
    required String addressLine2,
    required String landmark,
    required String city,
    required String state,
    required String country,
    required String pincode,
    String? latitude,
    String? longitude,
    required String addressType,
    required bool isDefault,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _repo.updateAddressApi(
        id: id,
        floor: floor,
        mobileNumber: mobileNumber,
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        landmark: landmark,
        city: city,
        state: state,
        country: country,
        pincode: pincode,
        latitude: latitude ?? '',
        longitude: longitude ?? '',
        addressType: addressType,
        isDefault: isDefault,
      );

      if (success) {
        await fetchAddresses();
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = "Failed to update address";
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }



  /// Delete address
  Future<bool> deleteAddress(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _repo.deleteAddressApi({}, id);
      if (response.success == true) {
        await fetchAddresses(); // refresh list
        return true;
      } else {
        _error = response.message ?? "Failed to delete address";
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// Set default address (extra function for UI convenience)
  Future<void> setDefaultAddress(String id) async {
    for (var addr in addresses) {
      addr.isDefault = addr.sId == id;
    }
    notifyListeners();
  }
}
