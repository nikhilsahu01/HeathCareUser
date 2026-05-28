import 'package:flutter/material.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';

import '../../appointments/view/appointments_Screen.dart';
import '../../booking/ui/booking_type.dart';
import '../../profile/view/profile_Screen.dart';
import '../../services/services_screen.dart';
import 'home_screen.dart';



class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  BottomNavControllerState createState() => BottomNavControllerState();
}

class BottomNavControllerState extends State<BottomNavController> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AppointmentScreen(isBack: false),
    const ServicesScreen(isSkip: false),
    const BookingTypeScreen(isBack: false),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) return; // FAB
    setState(() => _currentIndex = index);
  }

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        body: _pages[_currentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: ColorResource.primaryBlue,
          onPressed: () => setState(() => _currentIndex = 2),
          child: const Icon(Icons.medical_services_rounded, size: 32, color: Colors.white),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: SizedBox(
            height: screenHeight * 0.109, // responsive height
            // height: screenHeight * 0.13, // responsive height
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 6.0,
              color: ColorResource.primaryBlue,
              elevation: 10,
              child: SizedBox(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _buildBottomNavItem(
                          icon: Icons.home,
                          label: 'Home',
                          index: 0,
                        ),
                        _buildBottomNavItem(
                          icon: Icons.calendar_month_outlined,
                          label: 'Appointment',
                          index: 1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildBottomNavItem(
                          icon: Icons.chat_bubble_outline_rounded,
                          label: 'Consult',
                          index: 3,
                        ),
                        _buildBottomNavItem(
                          icon: Icons.person_outline,
                          label: 'Profile',
                          index: 4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white.withOpacity(isSelected ? 1 : 0.6),
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(isSelected ? 1 : 0.6),
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 2),
            // Small selection indicator
            // AnimatedContainer(
            //   duration: const Duration(milliseconds: 250),
            //   height: 3,
            //   width: isSelected ? 16 : 0,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(2),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
