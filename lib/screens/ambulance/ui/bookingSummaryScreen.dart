import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar:CustomAppBar(title: "Booking Summary"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 👨‍⚕️ Doctor Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  /// Doctor Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://randomuser.me/api/portraits/men/32.jpg",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Doctor Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Dr. Rahul Sharma",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text("Cardiologist"),
                        SizedBox(height: 4),
                        Text("10 Years Experience",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 📅 Appointment Details
            _sectionTitle("Appointment Details"),
            _infoCard([
              _infoRow("Date", "25 April 2026"),
              _infoRow("Time Slot", "10:30 AM - 11:00 AM"),
              _infoRow("Symptoms", "Chest pain, shortness of breath"),
            ]),

            const SizedBox(height: 16),

            /// 👤 Patient Details
            _sectionTitle("Patient Details"),
            _infoCard([
              _infoRow("Name", "Sartaj Kumar"),
              _infoRow("Age", "25"),
              _infoRow("Gender", "Male"),
            ]),

            const SizedBox(height: 16),

            /// 💰 Charges
            _sectionTitle("Charges"),
            _infoCard([
              _infoRow("Consultation Fee", "₹500"),
              _infoRow("Platform Fee", "₹50"),
              _infoRow("GST", "₹27"),
              const Divider(),
              _infoRow("Total Amount", "₹577", isBold: true),
            ]),

            const SizedBox(height: 16),

            /// ⚠️ Disclaimer
            _sectionTitle("Disclaimer"),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.yellow.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.yellow.shade200),
              ),
              child: const Text(
                "This appointment is subject to doctor availability. "
                    "Please reach 10 minutes before your scheduled time. "
                    "Fees once paid are non-refundable. In case of emergency, "
                    "contact nearest hospital immediately.",
                style: TextStyle(fontSize: 13),
              ),
            ),

            const SizedBox(height: 20),

            /// ✅ Confirm Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResource.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Confirm Booking",
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// 🔹 Section Title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// 🔹 Info Card
  Widget _infoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
    );
  }

  /// 🔹 Row
  Widget _infoRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}