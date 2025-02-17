// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, deprecated_member_use, file_names, unused_import, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madproject/const/colors.dart';
import 'package:madproject/modles/cart_model.dart';
import 'package:madproject/screens/changeAddressScreen.dart';
import 'package:madproject/screens/homeScreen.dart';
import 'package:madproject/screens/profileScreen.dart';
import 'package:madproject/services/firebase_services.dart';
import 'package:madproject/utils/helper.dart';
import 'package:madproject/widgets/customNavBar.dart';
import 'package:madproject/widgets/customTextInput.dart';
import 'package:madproject/widgets/toast.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = "/checkoutScreen";

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController lastName = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController mm = TextEditingController();
  final TextEditingController yy = TextEditingController();
  final TextEditingController securityCode = TextEditingController();
  final Services _firestoreService = Services();
  String? phoneNo, address;
  double totalprice = 0;
  double total = 0;
  double delivery = 50;
  List<Cart> cartItems = [];
  String a = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
    calculateTotalBill();
    //showToast(message: address);
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    List<Cart> items = await _firestoreService.getItemsFromCart();
    setState(() {
      cartItems = items;
    });
  }

  Future<void> calculateTotalBill() async {
    double fetchedTotalPrice = await _firestoreService.getTotalBill();
    setState(() {
      totalprice = fetchedTotalPrice;
      total = totalprice + delivery;
    });
  }

  Future<void> proceeedOrder() async {
    if (totalprice == 0) {
      showToast(message: "No item in cart");
    }
  }

  //get user phone and address
  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Retrieve the user's display name from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('userData')
          .doc(user.uid)
          .get();

      setState(() {
        address = userDoc.get('address');
        phoneNo = userDoc.get('mobileNo');
        a = userDoc.get('address');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              Colors.deepOrange, // Set the app bar background color
          title: Text(
            'Checkout',
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios_rounded),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SafeArea(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        //mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Delivery Address"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Helper.getScreenWidth(context) * 0.4,
                                  child: Text(
                                    address.toString(),
                                    style:
                                        Helper.getTheme(context).displaySmall,
                                  ),
                                ),
                                // TextButton(
                                //   onPressed: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             changeAddressScreen(address: a),
                                //       ),
                                //     );
                                //   },
                                //   child: Text(
                                //     "Change",
                                //     style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Phone No"),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Helper.getScreenWidth(context) * 0.4,
                                  child: Text(
                                    phoneNo.toString(),
                                    style:
                                        Helper.getTheme(context).displaySmall,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(ProfileScreen.routeName);
                                  },
                                  child: Text(
                                    "Change",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 10,
                            width: double.infinity,
                            color: AppColor.placeholderBg,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Sub Total"),
                                    Text(
                                      "\$$totalprice",
                                      style:
                                          Helper.getTheme(context).displaySmall,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Delivery Cost"),
                                    Text(
                                      "\$50",
                                      style:
                                          Helper.getTheme(context).displaySmall,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  height: 40,
                                  color: AppColor.placeholder.withOpacity(0.25),
                                  thickness: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total"),
                                    Text(
                                      "\$$total",
                                      style: Helper.getTheme(context).headline3,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 10,
                            width: double.infinity,
                            color: AppColor.placeholderBg,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (totalprice == 0) {
                                    showToast(message: "No item in cart");
                                  } else {
                                    _firestoreService.moveToOrder(cartItems);
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        isScrollControlled: true,
                                        isDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: Helper.getScreenHeight(
                                                    context) *
                                                0.8,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: Icon(Icons.clear),
                                                    ),
                                                  ],
                                                ),
                                                Image.asset(
                                                  Helper.getAssetName(
                                                    "vector4.png",
                                                    "virtual",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Thank You!",
                                                  style: TextStyle(
                                                    color: AppColor.primary,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 30,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "for your order",
                                                  style:
                                                      Helper.getTheme(context)
                                                          .headline4
                                                          ?.copyWith(
                                                              color: AppColor
                                                                  .primary),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0),
                                                  child: Text(
                                                      "Your order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your order"),
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: SizedBox(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                          "Track My Order"),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              HomeScreen
                                                                  .routeName);
                                                    },
                                                    child: Text(
                                                      "Back To Home",
                                                      style: TextStyle(
                                                        color: AppColor.primary,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                },
                                child: Text("Send Order"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  //),
                  Positioned(bottom: 0, left: 0, child: CustomNavBar()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class PaymentCard extends StatelessWidget {
//   const PaymentCard({
//     Key? key,
//     required Widget widget,
//   })  : _widget = widget,
//         super(key: key);
//   final Widget _widget;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//           height: 50,
//           width: double.infinity,
//           padding: const EdgeInsets.only(
//             left: 30,
//             right: 20,
//           ),
//           decoration: ShapeDecoration(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: BorderSide(
//                 color: AppColor.placeholder.withOpacity(0.25),
//               ),
//             ),
//             color: AppColor.placeholderBg,
//           ),
//           child: _widget),
//     );
//   }
// }
