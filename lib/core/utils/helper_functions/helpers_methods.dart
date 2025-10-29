import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../../coreServices/deviceInFoGetter.dart';


class HelperMethods {
  static void showCustomSnackbar(
      BuildContext context, {
        required String message,
        Color backgroundColor = Colors.red,
        Duration duration = const Duration(seconds: 3),
        SnackBarBehavior behavior = SnackBarBehavior.fixed,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: behavior,
      ),
    );
  }
  static void showFloatingToast(BuildContext context, {required String message, Color? color}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color ?? Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2)).then((_) => overlayEntry.remove());
  }

  static String formatAppointmentDate(String? dateString) {
    if (dateString == null || dateString == 'N/A') return 'N/A';

    try {
      final date = DateTime.parse(dateString);
      final formattedDate = DateFormat('EEEE d MMMM').format(date);
      return formattedDate;
    } catch (e) {
      print('Error formatting date: $e');
      return 'Invalid Date';
    }
  }
  static String getCurrentDateInUtcIsoFormat() {
    final now = DateTime.now().toUtc();
    return DateFormat("yyyy-MM-dd'T'00:00:00.000'Z'").format(now);
  }
  static bool isCurrentTimeWithinTimeSlot(String? timeSlot) {
    if (timeSlot == null || !timeSlot.contains(' - ')) return false;

    try {
      final parts = timeSlot.split(' - ');
      final startParts = parts[0].split(':');
      final endParts = parts[1].split(':');

      final now = DateTime.now();
      final startTime = DateTime(now.year, now.month, now.day, int.parse(startParts[0]), int.parse(startParts[1]));
      final endTime = DateTime(now.year, now.month, now.day, int.parse(endParts[0]), int.parse(endParts[1]));

      return now.isAfter(startTime) && now.isBefore(endTime);
    } catch (e) {
      print('Error parsing timeSlot: $e');
      return false;
    }
  }

  static Future<String?> getDeviceId() async {
    try {
      String? id = await AndroidDeviceInfoService().getAndroidDeviceId();
      print("Fetched Device ID: $id");
      return id;
    } catch (e) {
      print("Error getting device ID: $e");
      return null;
    }
  }


  static Future<Map<String, dynamic>?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        print("Location permission denied");
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("📍 Current Location: ${position.latitude}, ${position.longitude}");

      // Reverse geocoding to get landmark
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String landmark = "";
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        landmark = place.street ?? ""; // street/nearby landmark
        print("📍 Landmark (reverse geocode): $landmark");
      }

      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'landmark': landmark,
      };
    } catch (e) {
      print("Failed to get location: $e");
      return null;
    }
  }
}