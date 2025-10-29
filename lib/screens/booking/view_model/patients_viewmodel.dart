import 'package:flutter/material.dart';

import '../model/patients_model.dart';
import '../repo/booking_repository.dart';

class PatientsViewModel extends ChangeNotifier {
  final BookingRepository _repository = BookingRepository();

  bool isLoading = false;
  List<PatientData> patients = [];

  Future<void> fetchPatients() async {
    isLoading = true;
    notifyListeners();

    try {
      final model = await _repository.getPatientsList();
      patients = model.data ?? [];
    } catch (e) {
      debugPrint("❌ Error fetching patients: $e");
      patients = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> addPatient(String name) async {
    final success = await _repository.addNewPatient(name);
    if (success) {
      await fetchPatients();
    }
    return success;
  }

  Future<bool> removePatient(String id) async {
    final success = await _repository.removePatient(id);
    if (success) {
      await fetchPatients();
    }
    return success;
  }

  Future<bool> bookAppointment({
    required String patientId,
    var isEmergency,
    required String vendorId,
    required String appointmentDate,
    required String timeSlot,
    required String type,
    required String categoryId,
    required List<String> reminders,
    required String notes,
  }) async {
    return await _repository.bookAppointment(
      patientId: patientId,
      vendorId: vendorId,
      isEmergency: isEmergency == true ? "1":"0",
      appointmentDate: appointmentDate,
      timeSlot: timeSlot,
      type: type,
      reminders: reminders,
      notes: notes,
      categoryId: categoryId,
    );
  }
}
