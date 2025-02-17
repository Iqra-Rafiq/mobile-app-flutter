// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_new, file_names, prefer_const_constructors_in_immutables

//import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:madproject/const/colors.dart';
import 'package:madproject/modles/cart_model.dart';
//import 'package:madproject/screens/addToCartDialog.dart';
import 'package:madproject/utils/helper.dart';
import 'package:madproject/widgets/customNavBar.dart';
import 'package:madproject/services/firebase_services.dart';

class IndividualItem extends StatelessWidget {
  final String itemCategory;
  final String itemName;
  final String itemDescription;
  final String itemPrice;
  final String itemImage;
  final Services _firestoreService = Services();
  IndividualItem({
    required this.itemCategory,
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice,
    required this.itemImage,
  });
  static const routeName = "/individualScreen";
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: AppColor.orange,
              flexibleSpace: SizedBox(
                height: screenHeight * 0.5,
                width: screenWidth,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 220,
                      child: Center(
                        child: Image.asset(
                          Helper.getAssetName(
                            itemImage,
                            "real",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      itemName,
                      style: Helper.getTheme(context).titleLarge,
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Rs. $itemPrice",
                                style: TextStyle(
                                  color: AppColor.primary,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text("/per Portion")
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Description",
                      style: Helper.getTheme(context)
                          .headlineMedium
                          ?.copyWith(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      itemDescription,
                    ),
                    SizedBox(height: 20),
                    Divider(
                      color: AppColor.placeholder,
                      thickness: 1.5,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: screenWidth,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Create a Cart object with item details
                          Cart cart = Cart(
                            id: '',
                            pName: itemName,
                            pPrice: double.parse(itemPrice),
                            pDescription: itemDescription,
                            pImage: itemImage,
                            pQuantity: 1,
                            pCategory: itemCategory,
                          );
                          _firestoreService.addItemsToCart(cart);
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return AddToCartDialog(
                          //       itemName: itemName,
                          //       itemPrice: itemPrice
                          //           .toString(),
                          //     );
                          //   },
                          // );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Helper.getAssetName("add_to_cart.png", "virtual"),
                            ),
                            Text(
                              "Add to Cart",
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }

//   Widget build(BuildContext context) {
//   final screenHeight = MediaQuery.of(context).size.height;
//   final screenWidth = MediaQuery.of(context).size.width;
//   return Scaffold(
//     body: SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: screenHeight * 0.5,
//               width: screenWidth,
//               child: Image.asset(
//                 Helper.getAssetName(
//                   itemImage,
//                   "real",
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Icon(
//                               Icons.arrow_back_ios_rounded,
//                               color: Colors.black,
//                             ),
//                           ),
//                           // You can add more icons or widgets here if needed
//                         ],
//                       ),
//                     ),
//                     Text(
//                       itemName,
//                       style: Helper.getTheme(context).headlineSmall,
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 "Rs. $itemPrice",
//                                 style: TextStyle(
//                                   color: AppColor.primary,
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Text("/per Portion"),
//                             ],
//                           ),
//                         ),
//                         // You can add more details or widgets here if needed
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Description",
//                       style: Helper.getTheme(context).headlineMedium?.copyWith(
//                             fontSize: 16,
//                           ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       itemDescription,
//                     ),
//                     SizedBox(height: 20),
//                     Divider(
//                       color: AppColor.placeholder,
//                       thickness: 1.5,
//                     ),
//                     SizedBox(height: 20),
//                     SizedBox(
//                       width: screenWidth,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AddToCartDialog(
//                                 itemName: 'pName', // Replace with actual key
//                                 itemPrice: 'pPrice'
//                                     .toString(), // Replace with actual key
//                               );
//                             },
//                           );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               Helper.getAssetName(
//                                   "add_to_cart.png", "virtual"),
//                             ),
//                             Text(
//                               "Add to Cart",
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             CustomNavBar(),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}

// class CustomTriangle extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Offset controlpoint = Offset(size.width * 0, size.height * 0.5);
//     Offset endpoint = Offset(size.width * 0.2, size.height * 0.85);
//     Offset controlpoint2 = Offset(size.width * 0.33, size.height);
//     Offset endpoint2 = Offset(size.width * 0.6, size.height * 0.9);
//     Offset controlpoint3 = Offset(size.width * 1.4, size.height * 0.5);
//     Offset endpoint3 = Offset(size.width * 0.6, size.height * 0.1);
//     Offset controlpoint4 = Offset(size.width * 0.33, size.height * 0);
//     Offset endpoint4 = Offset(size.width * 0.2, size.height * 0.15);
//     Path path = new Path()
//       ..moveTo(size.width * 0.2, size.height * 0.15)
//       ..quadraticBezierTo(
//         controlpoint.dx,
//         controlpoint.dy,
//         endpoint.dx,
//         endpoint.dy,
//       )
//       ..quadraticBezierTo(
//         controlpoint2.dx,
//         controlpoint2.dy,
//         endpoint2.dx,
//         endpoint2.dy,
//       )
//       ..quadraticBezierTo(
//         controlpoint3.dx,
//         controlpoint3.dy,
//         endpoint3.dx,
//         endpoint3.dy,
//       )
//       ..quadraticBezierTo(
//         controlpoint4.dx,
//         controlpoint4.dy,
//         endpoint4.dx,
//         endpoint4.dy,
//       );
//     return path;
//   }
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
