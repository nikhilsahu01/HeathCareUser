import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:health_care/screens/booking/ui/specialisations_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../view_model/specialisation_viewModel.dart';
import '../view_model/symptoms_provider.dart';


class SymptomsListScreen extends StatefulWidget {
  final bool isEmergency;

  const SymptomsListScreen({super.key, this.isEmergency = false});

  @override
  State<SymptomsListScreen> createState() => _SymptomsListScreenState();
}

class _SymptomsListScreenState extends State<SymptomsListScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  void _handleTagInput(BuildContext context, String value) {
    // Manual input – not supported for tag addition unless it exists in suggestions
    _controller.clear();
  }

  void _onSearchChanged(BuildContext context, String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      Provider.of<SymptomsViewModel>(context, listen: false).fetchSymptoms(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'Symptoms'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            const CustomText(
              text: 'What are your symptoms?',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type to search symptoms...',
                filled: true,
                fillColor: const Color(0xFFF0F0F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onFieldSubmitted: (value) => _handleTagInput(context, value),
              onChanged: (value) => _onSearchChanged(context, value),
            ),
            const SizedBox(height: 16),
            Consumer<SymptomsViewModel>(
              builder: (context, provider, _) {
                final suggested = provider.suggestedSymptoms;
                final selected = provider.selectedSymptoms;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_controller.text.trim().isEmpty && selected.isEmpty && suggested.isEmpty)
                      Center(
                        child: Text(
                          '🔍 Please search and select your symptoms.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    if (_controller.text.trim().isNotEmpty && suggested.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'No matching symptoms found.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    if (suggested.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: 'Suggestions:',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: suggested.map((symptom) {
                              final name = symptom.name ?? '';
                              final alreadySelected = selected.any((s) => s.sId == symptom.sId);
                              return ChoiceChip(
                                label: Text(name),
                                selected: alreadySelected,
                                onSelected: (selected) {
                                  if (selected && !alreadySelected) {
                                    provider.addSymptom(symptom);
                                  }
                                },
                                selectedColor: Colors.green.shade100,
                                backgroundColor: const Color(0xFFE8F6F3),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    if (selected.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: selected.map((tag) {
                          return Chip(
                            label: Text(tag.name ?? ''),
                            deleteIcon: const Icon(Icons.cancel, size: 18),
                            onDeleted: () => provider.removeSymptom(tag),
                            backgroundColor: const Color(0xFFE8F6F3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomAppButton(
          label: 'Proceed',
          onPressed: () async {
            final provider = Provider.of<SymptomsViewModel>(context, listen: false);
            final selectedSymptoms = provider.selectedSymptoms;
            final selectedIds = selectedSymptoms.map((s) => s.sId).whereType<String>().toList();
            print('🩺 Proceeding with symptom IDs: $selectedIds');
            if(selectedSymptoms.isNotEmpty) {
              navSlideFromRight( context, SpecialisationsScreen(selectedCategoryIds: selectedIds,isEmergency: widget.isEmergency,));
              provider.clearSymptoms();
            } else {
              HelperMethods.showCustomSnackbar(context, message: 'Please choose your symptoms');
            }
          },
        ),
      ),
    );
  }
}

