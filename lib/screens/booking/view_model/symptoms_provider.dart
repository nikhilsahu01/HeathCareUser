import 'package:flutter/material.dart';

import '../../../core/utils/global_variables.dart';
import '../model/symptoms_list_model.dart';
import '../repo/booking_repository.dart';

class SymptomsViewModel extends ChangeNotifier {
  final List<Symtomps> _selectedSymptoms = [];
  List<Symtomps> get selectedSymptoms => _selectedSymptoms;

  List<Symtomps> _suggestedSymptoms = [];
  List<Symtomps> get suggestedSymptoms => _suggestedSymptoms;

  final BookingRepository _repository = BookingRepository();

  void addSymptom(Symtomps symptom) {
    final alreadyExists = _selectedSymptoms.any((s) => s.sId == symptom.sId);
    if (!alreadyExists) {
      _selectedSymptoms.add(symptom);
      if (symptom.name != null) globalSymptomName.add(symptom.name!);
      // String commaSeparated = globalSymptomName.join(', ');
      // print(commaSeparated);
      notifyListeners();
    }
  }

  void removeSymptom(Symtomps symptom) {
    _selectedSymptoms.removeWhere((s) => s.sId == symptom.sId);
    globalSymptomName.remove(symptom.name);
    // String commaSeparated = globalSymptomName.join(', ');
    // print(commaSeparated);
    notifyListeners();
  }

  void clearSymptoms() {
    _selectedSymptoms.clear();
    _suggestedSymptoms.clear();
    notifyListeners();
  }

  Future<void> fetchSymptoms(String symName) async {
    try {
      if (symName.trim().isEmpty) return;
      final response = await _repository.getSymptomsListApi(symName);
      _suggestedSymptoms = response.symtomps ?? [];
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error fetching symptoms: $e');
    }
  }
}
