import 'package:flutter/material.dart';

import '../model/slots_model.dart';
import '../repo/booking_repository.dart';

typedef SlotDate = String; // yyyy-MM-dd

class BookingSlotViewModel extends ChangeNotifier {
  final BookingRepository _repository = BookingRepository();

  bool isLoading = false;
  List<AvailableSlotsData> slots = [];
  List<String> reminderSlots = [];

  Future<void> getNewConsultantSlot({
    required BuildContext context,
    required String consultantId,
    required String date,
    String ? categoryId,
    String ? tabType,
  }) async {
    isLoading = true;
    slots = [];
    reminderSlots = [];
    notifyListeners();

    try {
      final availableSlotsModel = await _repository.getAvailableSlots(
        vendorId: consultantId,
        date: date,
      );

      slots = availableSlotsModel.data ?? [];
//todo enable for getting remider slots
      // Load reminder slots even if no available slots, if needed
      // final reminderModel = await _repository.getReminderSlots(
      //   vendorId: consultantId,
      //   date: date,
      // );
      // reminderSlots = reminderModel.data?.reminderSlots ?? [];

    } catch (e) {
      debugPrint("❌ Error fetching slots or reminders: $e");
      slots = [];
      reminderSlots = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
