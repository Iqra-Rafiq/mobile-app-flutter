// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, use_key_in_widget_constructors, file_names, library_private_types_in_public_api, unused_element, camel_case_types, prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:madproject/const/colors.dart';
import 'package:madproject/utils/helper.dart';
import 'package:madproject/widgets/customNavBar.dart';
import 'package:madproject/widgets/searchBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:madproject/widgets/toast.dart';

// class ChangeAddressScreen extends StatelessWidget {
//   static const routeName = "/changeAddressScreen";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 SafeArea(
//                   child: SingleChildScrollView(
//                     child: SizedBox(
//                        height: MediaQuery.of(context).size.height,
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 icon: Icon(
//                                   Icons.arrow_back_ios_rounded,
//                                 ),
//                               ),
//                               Text(
//                                 "Change Address",
//                                 style: Helper.getTheme(context).headlineSmall,
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Stack(
//                             children: [
//                               SizedBox(
//                                 height: Helper.getScreenHeight(context) * 0.6,
//                                 child: Image.asset(
//                                   Helper.getAssetName(
//                                     "map.png",
//                                     "real",
//                                   ),
//                                   fit: BoxFit.fitHeight,
//                                 ),
//                               ),
//                               Positioned(
//                                 bottom: 30,
//                                 right: 40,
//                                 child: Image.asset(
//                                   Helper.getAssetName(
//                                     "current_loc.png",
//                                     "virtual",
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 70,
//                                 right: 180,
//                                 child: Image.asset(
//                                   Helper.getAssetName(
//                                     "loc.png",
//                                     "virtual",
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 170,
//                                 left: 30,
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 20,
//                                     horizontal: 20,
//                                   ),
//                                   width: Helper.getScreenWidth(context) * 0.45,
//                                   decoration: ShapeDecoration(
//                                     color: AppColor.orange,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(10),
//                                         bottomLeft: Radius.circular(10),
//                                         bottomRight: Radius.circular(10),
//                                       ),
//                                     ),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         "Your Current Location",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                         "653 Nostrand Ave., Brooklyn, NY 11216",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 140,
//                                 right: 205,
//                                 child: ClipPath(
//                                   clipper: CustomTriangleClipper(),
//                                   child: Container(
//                                     width: 30,
//                                     height: 30,
//                                     color: AppColor.orange,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           //Searchbar(title: "Search Address"),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   height: 50,
//                                   width: 50,
//                                   decoration: ShapeDecoration(
//                                     shape: CircleBorder(),
//                                     color: AppColor.orange.withOpacity(0.2),
//                                   ),
//                                   child: Icon(
//                                     Icons.star_rounded,
//                                     color: AppColor.orange,
//                                     size: 30,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     "Choose a saved place",
//                                     style: TextStyle(
//                                       color: AppColor.primary,
//                                     ),
//                                   ),
//                                 ),
//                                 Icon(Icons.arrow_forward_ios_rounded)
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   child: CustomNavBar(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomTriangleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path()
//       ..moveTo(0, size.height)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(0, size.height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

class changeAddressScreen extends StatefulWidget {
  static const routeName = "/changeAddressScreen";
  final String address;

  changeAddressScreen({required this.address});

  @override
  _changeAddressScreenState createState() => _changeAddressScreenState();
}

class _changeAddressScreenState extends State<changeAddressScreen> {
  late GoogleMapController mapController;
  late LatLng userAddress = LatLng(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    fetchAddressCoordinates(); // Fetch coordinates from the address
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Address on Map'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          moveToUserAddress();
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0), // Initial position (center of the map)
          zoom: 12.0, // Initial zoom level
        ),
        markers: {
          Marker(
            markerId: MarkerId('user_address'),
            position: userAddress,
            infoWindow: InfoWindow(
              title: 'User Address',
              snippet: widget.address,
            ),
          ),
        },
      ),
    );
  }

  void moveToUserAddress() {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: userAddress,
          zoom: 14.0, // You can adjust the zoom level here
        ),
      ),
    );
  }

  void fetchAddressCoordinates() async {
    try {
      List<Location> locations = await locationFromAddress(widget.address);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        userAddress = LatLng(location.latitude, location.longitude);
        showToast(message: userAddress.toString());
      }
    } catch (e) {
      print('Error fetching coordinates: $e');
      // Handle error cases here
    }
  }
}
