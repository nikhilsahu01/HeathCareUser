import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/custom_widgets/custom_appBar.dart';
import '../viewmodel/help_center_viewmodel.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HelpCenterViewModel>().fetchHelpCenterData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HelpCenterViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Help Center"),
      body: SafeArea(
        child: vm.isLoading
            ? const Center(child: CircularProgressIndicator())
            : vm.faqs.isEmpty
                ? const Center(child: Text("No FAQs available yet."))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: vm.faqs.length,
                    itemBuilder: (context, index) {
                      final faq = vm.faqs[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        elevation: 0,
                        child: ExpansionTile(
                          title: Text(
                            faq['question'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                faq['answer'] ?? '',
                                style: const TextStyle(
                                  color: Colors.black54,
                                  height: 1.5,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
