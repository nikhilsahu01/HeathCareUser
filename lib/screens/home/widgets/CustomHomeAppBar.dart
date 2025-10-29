import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/custom_widgets/custom_threeDots_indecator.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../../location_screen/address_provider.dart';
import '../../location_screen/view/location_screen.dart';
import '../../notfications/view/notifications.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomHomeAppBar({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    navSlideFromTop(
                      context,
                      const LocationScreen(),
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 20),
                      const SizedBox(width: 6),

                      /// 👇 Wrap address text in Consumer
                      Consumer<AddressViewModel>(
                        builder: (context, addressVM, _) {
                          if (addressVM.isLoading) {
                            return const ThreeDotsLoader(color: ColorResource.primaryBlue,);
                          }

                          final addr = addressVM.defaultAddress;
                          if (addr == null || (addr.addressLine1?.isEmpty ?? true)) {
                            return const Text(
                              "+Add Address",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            );
                          }
                          final displayText =
                              "${addr.addressType ?? ''}, ${addr.city ?? ''}";

                          return Text(
                            displayText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ),
                CustomImageView(
                  onTap: () {
                    navSlideFromTop(context, const NotificationScreen());
                  },
                  imagePath: 'assets/images/notificationIcon.png',
                  height: 40,
                  width: 40,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: ColorResource.lightBlue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: ColorResource.lightBlue,
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                  hintText: "Search...",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
