// ignore_for_file: prefer_const_constructors, unused_field, sized_box_for_whitespace, use_key_in_widget_constructors, unused_import, file_names

import 'package:flutter/material.dart';
import 'package:madproject/const/colors.dart';
import 'package:madproject/screens/aboutScreen.dart';
import 'package:madproject/screens/favouriteScreen.dart';
import 'package:madproject/screens/inboxScreen.dart';
import 'package:madproject/screens/myOrderScreen.dart';
import 'package:madproject/screens/notificationScreen.dart';
import 'package:madproject/screens/orderScreen.dart';
import 'package:madproject/screens/paymentScreen.dart';
import 'package:madproject/utils/helper.dart';
import 'package:madproject/widgets/customNavBar.dart';
import 'package:madproject/services/firebase_services.dart';
import 'package:madproject/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class MoreScreen extends StatelessWidget {
  static const routeName = "/moreScreen";
  final AuthMethod _firestoreService = AuthMethod();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "More",
                  //       style: Helper.getTheme(context).headlineSmall,
                  //     ),
                  //     Image.asset(
                  //       Helper.getAssetName("cart.png", "virtual"),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  // MoreCard(
                  //   image: Image.asset(
                  //     Helper.getAssetName("income.png", "virtual"),
                  //   ),
                  //   name: "Payment Details",
                  //   handler: () {
                  //     Navigator.of(context).pushNamed(PaymentScreen.routeName);
                  //   },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Helper.getAssetName("shopping_bag.png", "virtual"),
                    ),
                    name: "My Orders",
                    handler: () {
                      Navigator.of(context).pushNamed(orderScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Helper.getAssetName("favourite.png", "virtual"),
                    ),
                    name: "My Favourites",
                    handler: () {
                      Navigator.of(context).pushNamed(FavoriteScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Helper.getAssetName("info.png", "virtual"),
                    ),
                    name: "About Us",
                    handler: () {
                      Navigator.of(context).pushNamed(AboutScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Helper.getAssetName("user.png", "virtual"),
                    ),
                    name: "Sign Out",
                    handler: () {
                      _firestoreService.signOut(context);
                      //Navigator.of(context).pushNamed(InboxScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              more: true,
            ),
          )
        ],
      ),
    );
  }
}

class MoreCard extends StatelessWidget {
  const MoreCard({
    Key? key,
    required String name,
    required Image image,
    bool isNoti = false,
    required Function()? handler,
  })  : _name = name,
        _image = image,
        _isNoti = isNoti,
        _handler = handler,
        super(key: key);

  final String _name;
  final Image _image;
  final bool _isNoti;
  final Function()? _handler;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handler, // Reinstating onTap handler
      child: Container(
        height: 70,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.only(
                right: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColor.placeholderBg,
              ),
              child: Row(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: AppColor.placeholder,
                      ),
                      child: _image),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _name,
                    style: TextStyle(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 30,
                width: 30,
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: AppColor.placeholderBg,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.secondary,
                  size: 17,
                ),
              ),
            ),
            if (_isNoti)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(
                    right: 50,
                  ),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      "15",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
