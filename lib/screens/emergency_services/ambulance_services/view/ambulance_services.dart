import 'package:flutter/material.dart';
import '../../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../widgets/radio_button_dialogue.dart';


class AmbulanceServiceOptionsScreen extends StatelessWidget {
  const AmbulanceServiceOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isSmallScreen = width < 360;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Emergency Services'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: height * 0.03,
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.05),

          _gradientButton(
            context: context,
            label: 'Book For Now',
            gradient: const LinearGradient(
              colors: [Color(0xFF68C3B8), Color(0xFF4AA79D)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return BookingDialog(bookingFor: 'bookingForNow',);
                },
              );
            },
          ),
            SizedBox(height: height * 0.03),
            _gradientButton(
              context: context,
              label: 'Book For Later',
              gradient: const LinearGradient(
                colors: [Color(0xFFF9E79F), Color(0xFFB4D56B)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return BookingDialog(bookingFor: 'bookingForLater',);
                  },
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _gradientButton({
    required BuildContext context,
    required String label,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    final width = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxWidth * 0.60;
        final fontSize = constraints.maxWidth * 0.09;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            height: height.clamp(55, 80),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize.clamp(14.0, 20.0),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
        );
      },
    );
  }
}
