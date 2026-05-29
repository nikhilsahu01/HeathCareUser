import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import '../../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../../core/utils/theams/color_resource.dart';
import '../widgets/custom_fileUpload_dialogue.dart';
import '../viewmodel/health_record_viewmodel.dart';

class HealthRecordsListScreen extends StatefulWidget {
  const HealthRecordsListScreen({super.key});

  @override
  State<HealthRecordsListScreen> createState() => _HealthRecordsListScreenState();
}

class _HealthRecordsListScreenState extends State<HealthRecordsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HealthRecordViewModel>(context, listen: false).fetchHealthRecords();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final vm = Provider.of<HealthRecordViewModel>(context);

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'Health Record'),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.05,),
                CustomImageView(imagePath: 'assets/images/healthRecBg.png'),
                SizedBox(height: screenHeight * 0.05,),
              vm.isLoading && vm.healthRecords.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : vm.healthRecords.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: vm.healthRecords.length,
                          itemBuilder: (context, index) {
                            final record = vm.healthRecords[index];
                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                                title: Text(record['title'] ?? 'Health Record', style: TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text(record['createdAt'] != null ? record['createdAt'].toString().substring(0, 10) : ''),
                                trailing: IconButton(
                                  icon: Icon(Icons.download, color: ColorResource.primaryBlue),
                                  onPressed: () {
                                    // Handle download/view if needed
                                    // For now, it just shows it's available
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(child: Text("No records found.", style: TextStyle(color: Colors.grey))),
              const SizedBox(height: 20),
              vm.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : CustomAppButton(label: '+Add Healthcare', onPressed: (){
                showDialog(
                  context: context,
                  builder: (_) => CustomFileUpload(
                    message: "Choose File(PDF/ Image/Scan)",
                    onPressed: () async {
                      Navigator.pop(context); // Close the dialog
                      
                      FilePickerResult? result = await FilePicker.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
                      );

                      if (result != null && result.files.single.path != null) {
                        String filePath = result.files.single.path!;
                        String fileName = result.files.single.name;
                        
                        bool success = await vm.uploadHealthRecord(filePath, fileName);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Health Record uploaded successfully!"))
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Upload failed. Please try again."))
                          );
                        }
                      }
                    },
                  ),
                );
              })
            ],
          )
        ),
      ),
    );
  }
}