import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import '../../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../../core/utils/theams/color_resource.dart';
import '../viewmodel/health_record_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class PrescriptionsListScreen extends StatefulWidget {
  const PrescriptionsListScreen({super.key});

  @override
  State<PrescriptionsListScreen> createState() => _PrescriptionsListScreenState();
}

class _PrescriptionsListScreenState extends State<PrescriptionsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HealthRecordViewModel>(context, listen: false).fetchHealthRecords();
    });
  }

  void _openPrescription(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open prescription')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final vm = Provider.of<HealthRecordViewModel>(context);

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'My Prescriptions'),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.05,),
                vm.isLoading && vm.prescriptions.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : vm.prescriptions.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: vm.prescriptions.length,
                            itemBuilder: (context, index) {
                              final record = vm.prescriptions[index];
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: Icon(Icons.description, color: Colors.green),
                                  title: Text("Prescription", style: TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text(record['createdAt'] != null ? record['createdAt'].toString().substring(0, 10) : ''),
                                  trailing: IconButton(
                                    icon: Icon(Icons.download, color: ColorResource.primaryBlue),
                                    onPressed: () {
                                      if (record['image'] != null) {
                                        _openPrescription(record['image']);
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(child: Text("No prescriptions found.", style: TextStyle(color: Colors.grey))),
                const SizedBox(height: 20),
              ],
            )
        ),
      ),
    );
  }
}
