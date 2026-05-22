import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:health_care/core/api_service/app_url.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? selectedLatLng;
  String selectedAddress = "";
  Placemark? selectedPlace; //
  TextEditingController searchController = TextEditingController();
  GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Select Location"),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(28.6139, 77.2090), // Delhi
              zoom: 14,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },
            onTap: (latLng) async {
              selectedLatLng = latLng;

              List<Placemark> placemarks =
              await placemarkFromCoordinates(
                  latLng.latitude, latLng.longitude);

              selectedPlace = placemarks.first; // 👈 SAVE HERE

              setState(() {
                selectedAddress =
                "${selectedPlace!.name}, ${selectedPlace!.locality}, ${selectedPlace!.administrativeArea}, ${selectedPlace!.postalCode}, ${selectedPlace!.country}";
              });
            },
            markers: selectedLatLng == null
                ? {}
                : {
              Marker(
                markerId: const MarkerId("selected"),
                position: selectedLatLng!,
              )
            },
          ),
          Positioned(
            top: 10,
            left: 16,
            right: 16,
            child: GooglePlaceAutoCompleteTextField(
              textEditingController: searchController,
              googleAPIKey: AppUrl.apiKey,
              inputDecoration: InputDecoration(
                hintText: "Search location",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              debounceTime: 800,

              // countries: ["in"], // India only (optional)

              isLatLngRequired: true,

              getPlaceDetailWithLatLng: (prediction) async {
                double lat = double.parse(prediction.lat!);
                double lng = double.parse(prediction.lng!);

                selectedLatLng = LatLng(lat, lng);

                /// Move map
                mapController?.animateCamera(
                  CameraUpdate.newLatLng(selectedLatLng!),
                );

                /// Get address
                final placemarks =
                await placemarkFromCoordinates(lat, lng);

                selectedPlace = placemarks.first;

                setState(() {
                  selectedAddress =
                  "${selectedPlace!.name}, ${selectedPlace!.locality}, ${selectedPlace!.administrativeArea}, ${selectedPlace!.postalCode}, ${selectedPlace!.country}";
                });
              },

              itemClick: (prediction) {
                searchController.text = prediction.description!;
              },
            ),
          ),
          /// 🔍 Address Preview
          if (selectedAddress.isNotEmpty)
            Positioned(
              bottom: 40,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Text(selectedAddress),
              ),
            ),

          /// ✅ Confirm Button
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                if (selectedPlace == null) return;

                Navigator.pop(context, {
                  "address": selectedAddress,
                  "city": selectedPlace!.locality,
                  "state": selectedPlace!.administrativeArea,
                  "pincode": selectedPlace!.postalCode,
                  "country": selectedPlace!.country,
                });
              },
              child: const Text("Confirm Location",style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}