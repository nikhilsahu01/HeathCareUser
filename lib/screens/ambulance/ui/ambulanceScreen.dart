import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../core/api_service/app_url.dart';
import '../../../core/utils/theams/color_resource.dart';



class NearbyAmbulanceScreen extends StatefulWidget {
  const NearbyAmbulanceScreen({Key? key}) : super(key: key);

  @override
  State<NearbyAmbulanceScreen> createState() =>
      _NearbyAmbulanceScreenState();
}

class _NearbyAmbulanceScreenState extends State<NearbyAmbulanceScreen> {
  List<Map<String, dynamic>> hospitals = [];
  bool isLoading = true;

  late GoogleApiService api;

  @override
  void initState() {
    super.initState();
    api = GoogleApiService(AppUrl.apiKey);
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      /// 1. Check permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      /// 2. If still denied → handle
      if (permission == LocationPermission.denied) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied")),
        );
        return;
      }

      /// 3. If permanently denied
      if (permission == LocationPermission.deniedForever) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Enable location from settings")),
        );
        return;
      }

      /// 4. Get location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      /// 5. API call
      final result = await api.getNearbyHospitals(
        position.latitude,
        position.longitude,
      );

      setState(() {
        hospitals = result;
        isLoading = false;
      });

    } catch (e) {
      setState(() => isLoading = false);
      print("ERROR: $e");
    }
  }

  /// ✅ Call Function
  void callNumber(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(title: "Nearest Ambulance"),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final place = hospitals[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🏥 Image / Icon
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: place['photos'] != null
                      ? Image.network(
                    "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${place['photos'][0]['photo_reference']}&key=${AppUrl.apiKey}",
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 70,
                        width: 70,
                        color: Colors.blue.shade50,
                        child: const Icon(Icons.local_hospital,
                            color: Colors.blue, size: 30),
                      );
                    },
                  )
                      : Container(
                    height: 70,
                    width: 70,
                    color: Colors.blue.shade50,
                    child: const Icon(Icons.local_hospital,
                        color: Colors.blue, size: 30),
                  ),
                ),

                const SizedBox(width: 12),

                /// 📄 Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Name
                      Text(
                        place['name'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// Address
                      Text(
                        place['vicinity'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// ⭐ Rating (optional)
                      if (place['rating'] != null)
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.orange, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              place['rating'].toString(),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),

                      const SizedBox(height: 10),

                      /// 📞 CALL BUTTON
                      SizedBox(
                        height: 36,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:ColorResource.primaryBlue, // 🔵 dark blue
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            String? phone =
                            await api.getPlacePhone(place['place_id']);

                            if (phone != null) {
                              callNumber(phone);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Phone number not available"),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.call, size: 20,color: Colors.white),
                          label: const Text("Call Now",style: TextStyle(color: Colors.white,fontSize: 13),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

          // return Card(
          //   margin: const EdgeInsets.all(10),
          //   child: ListTile(
          //     title: Text(place['name'] ?? ''),
          //     subtitle: Text(place['vicinity'] ?? ''),
          //
          //     /// 📞 CALL BUTTON
          //     trailing: IconButton(
          //       icon: const Icon(Icons.call, color: Colors.green),
          //       onPressed: () async {
          //         String? phone =
          //         await api.getPlacePhone(place['place_id']);
          //
          //         if (phone != null) {
          //           callNumber(phone);
          //         } else {
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             const SnackBar(
          //                 content: Text("Phone number not available")),
          //           );
          //         }
          //       },
          //     ),
          //   ),
          // );
        },
      ),

      /// 🚑 Emergency Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => callNumber("108"),
        label: const Text("Call 108"),
        icon: const Icon(Icons.emergency),
      ),
    );
  }
}




class GoogleApiService {
  final String apiKey;

  GoogleApiService(this.apiKey);

  /// Get Nearby Hospitals
  Future<List<Map<String, dynamic>>> getNearbyHospitals(
      double lat, double lng) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
          '?location=$lat,$lng&radius=5000&type=hospital&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    }
    return [];
  }

  /// Get Phone Number
  Future<String?> getPlacePhone(String placeId) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json'
          '?place_id=$placeId&fields=name,formatted_phone_number&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['result']['formatted_phone_number'];
    }
    return null;
  }
}