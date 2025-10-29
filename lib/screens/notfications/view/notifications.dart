import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/custom_widgets/custom_threeDots_indecator.dart';
import '../notifications_viewmodel/notifications_provider.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final provider = Provider.of<NotificationProvider>(context, listen: false);
      await provider.getNotification(
        context: context,


      );
    } catch (e) {
      log('Exception in getData: $e');
    }
  }
  @override
  void dispose() {
    // Clear the list when screen is disposed (back pressed)
    Provider.of<NotificationProvider>(context, listen: false).notificationModel==null;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Notifications",),
      body:Consumer<NotificationProvider>(builder: (context, pro, child) {
        if(pro.notificationModel==null||pro.notificationModel!.data==null){
          return SizedBox(
            height: height,
            width: width,
            child: Center(
              child: ThreeDotsLoader(),
            ),
          );
        }if(pro.notificationModel!.data!.isEmpty){
          return SizedBox(
            height: height,
            width: width,
            child: Center(
              child: Text("Not Available"),
            ),
          );
        }
        return  ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: pro.notificationModel!.data!.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = pro.notificationModel!.data![index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorResource.lightBlue,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorResource.primaryBlue),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:  item.title ?? '',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.message ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    formatRelativeTime(item.createdAt ?? ''),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        );
      },),
    );
  }


  String formatRelativeTime(String createdAt) {
    try {
      final dateTime = DateTime.parse(createdAt).toLocal();
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inSeconds < 60) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays == 0) {
        return 'Today';
      } else {
        return DateFormat('dd MMM yyyy').format(dateTime);
      }
    } catch (e) {
      return createdAt; // fallback
    }
  }

}