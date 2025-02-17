// ignore_for_file: unused_import, use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors, unused_element, unused_field, prefer_final_fields, unused_local_variable, prefer_typing_uninitialized_variables, file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madproject/const/colors.dart';
import 'package:madproject/utils/helper.dart';
import 'package:madproject/widgets/customNavBar.dart';
import 'package:madproject/widgets/customTextInput.dart';
import 'package:madproject/services/firebase_services.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  // late PageController _pageController;
  // int _selectedIndex = 0;
  User? user;
  late FirebaseFirestore _firestore;
  Services _firestoreService = Services();

  String? _userName;
  String? _userEmail;
  String? _userMobileNo;
  //String? _displayName;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    fetchUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchUserData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('userData').doc(user!.uid).get();
      if (userData.exists) {
        // Retrieve user data and update the UI
        setState(() {
          _userName = userData['name'];
          _userEmail = userData['email'];
          // userAddress = userData['address'];
          _userMobileNo = userData['mobileNo'];
          // Set these retrieved values to variables and use them in your UI
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Stack(
            children: [
              SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors
                                      .deepOrange, // Set the desired color here
                                ),
                                padding:
                                    const EdgeInsets.only(left: 35, top: 8),
                                child: Text(
                                  "Profile",
                                  style: TextStyle(
                                    color:
                                        Colors.white, // Set text color to white
                                    fontWeight:
                                        FontWeight.bold, // Make text bold
                                    fontSize:
                                        30, // Adjust the font size as needed
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ClipOval(
                            child: Stack(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset(
                                    Helper.getAssetName(
                                      "user.jpg",
                                      "real",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: 20,
                                    width: 80,
                                    color: Colors.black.withOpacity(0.3),
                                    child: Image.asset(Helper.getAssetName(
                                        "camera.png", "virtual")),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Hi $_userName',
                            style: Helper.getTheme(context)
                                .headlineMedium
                                ?.copyWith(
                                  color: AppColor.primary,
                                ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          CustomFormImput(
                            label: "Name",
                            value: _userName,
                            isEnabled: _isEditing,
                            onChanged: (newValue) {
                              setState(() {
                                _userName =
                                    newValue; // Update the _userMobileNo value
                              });
                            },
                            
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomFormImput(
                            label: "Email",
                            value: _userEmail,
                            isEnabled: _isEditing,
                            onChanged: (newValue) {
                              setState(() {
                                _userEmail =
                                    newValue; // Update the _userMobileNo value
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomFormImput(
                            label: "Mobile No",
                            value: _userMobileNo,
                            isEnabled: _isEditing,
                            onChanged: (newValue) {
                              setState(() {
                                _userMobileNo =
                                    newValue; // Update the _userMobileNo value
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_isEditing) {
                                  await _firestoreService.updateUserData(
                                    name: _userName ?? '',
                                    email: _userEmail ?? '',
                                    mobileNo: _userMobileNo ?? '',
                                  );
                                  setState(() {
                                    _isEditing = false;
                                  });
                                } else {
                                  setState(() {
                                    _isEditing = true;
                                  });
                                }
                              },
                              child: Text(
                                _isEditing ? "Save" : "Edit Profile",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: CustomNavBar(),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class CustomFormImput extends StatelessWidget {
  const CustomFormImput({
    Key? key,
    required this.label,
    required this.value,
    required this.isEnabled,
    required this.onChanged,
  }) : super(key: key);

  final String? label;
  final String? value;
  final bool isEnabled;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40, top: 5),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: Colors.grey[200],
      ),
      child: isEnabled
          ? TextFormField(
              enabled: isEnabled,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: label,
                contentPadding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
              ),
              initialValue: value,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 14,
              ),
            )
          : Text(
              value ?? '',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
    );
  }
}
