import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:provider/provider.dart';

import '../viewmodel/cms_viewmodel.dart';

class CmsScreen extends StatefulWidget {

  final String type;

  const CmsScreen({
    super.key,
    required this.type,
  });

  @override
  State<CmsScreen> createState() => _CmsScreenState();
}

class _CmsScreenState extends State<CmsScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CmsViewModel>().getCmsData();
    });
  }

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<CmsViewModel>(context);

    String title = "";
    String content = "";

    if (vm.cmsModel != null &&
        vm.cmsModel!.data != null &&
        vm.cmsModel!.data!.isNotEmpty) {

      final cmsData = vm.cmsModel!.data![0];

      /// TITLE

      if (widget.type == "about") {

        title = "About Us";

        content = cmsData.termCondition ?? "";

      }
      else if (widget.type == "privacy") {

        title = "Privacy Policy";

        content = cmsData.privacyPolicy ?? "";
      }
      else {

        title = "Terms & Conditions";

        content = cmsData.aboutUs ?? "";
      }
    }

    return Scaffold(

      appBar: CustomAppBar(title: title),

      body: vm.isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(

          child: Html(
            data: content,
          ),

        ),
      ),
    );
  }
}