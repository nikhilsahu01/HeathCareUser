import 'package:flutter/material.dart';

import '../../../core/utils/custom_widgets/custom_appBar.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Help Center"),

      body: SafeArea(child: SingleChildScrollView(
        child: Center(
          child: Text("Up Coming Help Center"),
        ),
      )),
    );
  }
}
