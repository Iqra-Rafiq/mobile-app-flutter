// // ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, unused_field, file_names

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../const/colors.dart';
// import '../utils/helper.dart';
// import '../widgets/customNavBar.dart';
// import '../screens/individualItem.dart';
// import '../widgets/searchBar.dart';

// class HomeScreen extends StatefulWidget {
//   static const routeName = "/homeScreen";

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late PageController _pageController;
//   int _selectedIndex = 0;

//   final Map<String, List<Map<String, dynamic>>> menuItems = {
//     'Burgers': [
//       {
//         'title': 'Item 1',
//         'description': 'Description for Item 1',
//         'price': 'Rs. 100.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//       {
//         'title': 'Item 2',
//         'description': 'Description for Item 2',
//         'price': 'Rs. 120.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//       {
//         'title': 'Item 3',
//         'description': 'Description for Item 3',
//         'price': 'Rs. 90.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//       {
//         'title': 'Item 4',
//         'description': 'Description for Item 4',
//         'price': 'Rs. 150.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//       {
//         'title': 'Item 5',
//         'description': 'Description for Item 5',
//         'price': 'Rs. 80.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//     ],
//     'Shawarmas': [
//       {
//         'title': 'Item A',
//         'description': 'Description for Item A',
//         'price': 'Rs. 200.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//       {
//         'title': 'Item B',
//         'description': 'Description for Item B',
//         'price': 'Rs. 180.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//       {
//         'title': 'Item C',
//         'description': 'Description for Item C',
//         'price': 'Rs. 220.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//       {
//         'title': 'Item D',
//         'description': 'Description for Item D',
//         'price': 'Rs. 250.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//       {
//         'title': 'Item E',
//         'description': 'Description for Item E',
//         'price': 'Rs. 210.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//     ],
//     'Pizzas': [
//       {
//         'title': 'Item X',
//         'description': 'Description for Item X',
//         'price': 'Rs. 300.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//       {
//         'title': 'Item Y',
//         'description': 'Description for Item Y',
//         'price': 'Rs. 280.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//       {
//         'title': 'Item Z',
//         'description': 'Description for Item Z',
//         'price': 'Rs. 320.00',
//         'image': 'assets/images/real/fruit.jpg',
//       },
//       {
//         'title': 'Item W',
//         'description': 'Description for Item W',
//         'price': 'Rs. 350.00',
//         'image': 'assets/images/real/fruit.jpg',
//       },
//       {
//         'title': 'Item Q',
//         'description': 'Description for Item Q',
//         'price': 'Rs. 330.00',
//         'image': 'assets/images/real/fruit.jpg',
//       },
//     ],
//     'Pastas': [
//       {
//         'title': 'Item 1',
//         'description': 'Description for Item 1',
//         'price': 'Rs. 100.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//       {
//         'title': 'Item 2',
//         'description': 'Description for Item 2',
//         'price': 'Rs. 120.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//       {
//         'title': 'Item 3',
//         'description': 'Description for Item 3',
//         'price': 'Rs. 90.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//       {
//         'title': 'Item 4',
//         'description': 'Description for Item 4',
//         'price': 'Rs. 150.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//       {
//         'title': 'Item 5',
//         'description': 'Description for Item 5',
//         'price': 'Rs. 80.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//     ],
//     'Deals': [
//       {
//         'title': 'Item A',
//         'description': 'Description for Item A',
//         'price': 'Rs. 200.00',
//         'image': 'assets/images/real/hamburger2.jpg',
//       },
//       {
//         'title': 'Item B',
//         'description': 'Description for Item B',
//         'price': 'Rs. 180.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//       {
//         'title': 'Item C',
//         'description': 'Description for Item C',
//         'price': 'Rs. 220.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//       {
//         'title': 'Item D',
//         'description': 'Description for Item D',
//         'price': 'Rs. 250.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//       {
//         'title': 'Item E',
//         'description': 'Description for Item E',
//         'price': 'Rs. 210.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//     ],
//     'Starters': [
//       {
//         'title': 'Item X',
//         'description': 'Description for Item X',
//         'price': 'Rs. 300.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//       {
//         'title': 'Item Y',
//         'description': 'Description for Item Y',
//         'price': 'Rs. 280.00',
//         'image': 'assets/images/real/rice2.jpg',
//       },
//       {
//         'title': 'Item Z',
//         'description': 'Description for Item Z',
//         'price': 'Rs. 320.00',
//         'image': 'assets/images/real/fruit.jpg',
//       },
//       {
//         'title': 'Item W',
//         'description': 'Description for Item W',
//         'price': 'Rs. 350.00',
//         'image': 'assets/images/real/fruit.jpg',
//       },
//       {
//         'title': 'Item Q',
//         'description': 'Description for Item Q',
//         'price': 'Rs. 330.00',
//         'image': 'assets/images/real/fruit.jpg',
//       },
//     ],
//   };

//   late User? _user;
//   String? _displayName;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//     _pageController = PageController(initialPage: _selectedIndex);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchUserData() async {
//     User? user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       // User is signed in
//       setState(() {
//         _user = user;
//       });

//       // Retrieve the user's display name from Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('userData')
//           .doc(user.uid)
//           .get();

//       setState(() {
//         _displayName = userDoc.get('name');
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GestureDetector(
//           onHorizontalDragEnd: (details) {
//             if (details.primaryVelocity! > 0 && _selectedIndex > 0) {
//               setState(() {
//                 _selectedIndex--;
//               });
//             } else if (details.primaryVelocity! < 0 &&
//                 _selectedIndex < menuItems.keys.length - 1) {
//               setState(() {
//                 _selectedIndex++;
//               });
//             }
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 70,
//                 color: Colors.deepOrange,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Good morning $_displayName",
//                         style: Helper.getTheme(context).headline5?.copyWith(
//                               color:
//                                   Colors.white, // Set the text color to white
//                             ),
//                       ),
//                       Image.asset(
//                           Helper.getAssetName("cart_white.png", "virtual")),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Searchbar(
//                 title: "Search Food",
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: menuItems.keys.map((category) {
//                     int index = menuItems.keys.toList().indexOf(category);
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedIndex = index;
//                         });
//                       },
//                       child: Material(
//                         color: Colors.transparent,
//                         textStyle: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                         child: Ink(
//                           decoration: BoxDecoration(
//                             border: _selectedIndex == index
//                                 ? Border(
//                                     bottom: BorderSide(
//                                       color: Colors.deepOrange,
//                                       width: 2.0,
//                                     ),
//                                   )
//                                 : null,
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 _selectedIndex = index;
//                               });
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 8.0,
//                                 horizontal: 16.0,
//                               ),
//                               child: Text(
//                                 category,
//                                 style: TextStyle(
//                                   color: _selectedIndex == index
//                                       ? Colors.deepOrange
//                                       : Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),

//               SizedBox(height: 20.0),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: menuItems.keys.length,
//                   itemBuilder: (context, index) {
//                     final category = menuItems.keys.toList()[index];
//                     final items = menuItems[category]!;
//                     return _buildItemsList(
//                         category, items, _selectedIndex == index);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: CustomNavBar(home: true),
//     );
//   }

//   Widget _buildItemsList(
//       String category, List<Map<String, dynamic>> items, bool isSelected) {
//     return Visibility(
//       visible: isSelected,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: items.map((item) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () {
//                 _navigateToItemDetails(
//                     item); // Navigate to the single item page
//               },
//               child: Card(
//                 elevation: 5, // Adjust the elevation as needed
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: 100.0,
//                         height: 100.0,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(item['image']),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10.0),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               item['title'],
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 4.0),
//                             Text(item['description']),
//                             SizedBox(height: 4.0),
//                             Text(
//                               item['price'],
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 8.0),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Add to cart functionality
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     primary: Colors
//                                         .deepOrange, // Button background color
//                                     padding: EdgeInsets.zero, // No padding
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           5.0), // Adjust the border radius as needed
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 10, top: 5, right: 10, bottom: 5),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           'Add',
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color: Colors.white, // Text color
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(width: 5),
//                                         Icon(
//                                           Icons.add_shopping_cart,
//                                           color: Colors.white, // Icon color
//                                         ),
//                                         // Adjust spacing between icon and text
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     Icons.favorite_border,
//                                     color: Theme.of(context)
//                                         .primaryColor, // Use the primary color from the theme
//                                   ),
//                                   onPressed: () {
//                                     // Add to favorites functionality
//                                   },
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   void _navigateToItemDetails(Map<String, dynamic> item) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => IndividualItem(),
//       ),
//     );
//   }
// }

// // class RecentItemCard extends StatelessWidget {
// //   const RecentItemCard({
// //     Key? key,
// //     required String name,
// //     required Image image,
// //   })  : _name = name,
// //         _image = image,
// //         super(key: key);

// //   final String _name;
// //   final Image _image;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         ClipRRect(
// //           borderRadius: BorderRadius.circular(10),
// //           child: Container(
// //             width: 80,
// //             height: 80,
// //             child: _image,
// //           ),
// //         ),
// //         SizedBox(
// //           width: 10,
// //         ),
// //         Expanded(
// //           child: Container(
// //             height: 100,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   _name,
// //                   style: Helper.getTheme(context)
// //                       .headline4
// //                       ?.copyWith(color: AppColor.primary),
// //                 ),
// //                 Row(
// //                   children: [
// //                     Text("Cafe"),
// //                     SizedBox(
// //                       width: 5,
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.only(bottom: 5.0),
// //                       child: Text(
// //                         ".",
// //                         style: TextStyle(
// //                           color: AppColor.orange,
// //                           fontWeight: FontWeight.w900,
// //                         ),
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       width: 5,
// //                     ),
// //                     Text("Western Food"),
// //                     SizedBox(
// //                       width: 20,
// //                     ),
// //                   ],
// //                 ),
// //                 Row(
// //                   children: [
// //                     Image.asset(
// //                       Helper.getAssetName("star_filled.png", "virtual"),
// //                     ),
// //                     SizedBox(
// //                       width: 5,
// //                     ),
// //                     Text(
// //                       "4.9",
// //                       style: TextStyle(
// //                         color: AppColor.orange,
// //                       ),
// //                     ),
// //                     SizedBox(width: 10),
// //                     Text('(124) Ratings')
// //                   ],
// //                 )
// //               ],
// //             ),
// //           ),
// //         )
// //       ],
// //     );
// //   }
// // }

// // class MostPopularCard extends StatelessWidget {
// //   const MostPopularCard({
// //     Key? key,
// //     required String name,
// //     required Image image,
// //   })  : _name = name,
// //         _image = image,
// //         super(key: key);

// //   final String _name;
// //   final Image _image;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         ClipRRect(
// //           borderRadius: BorderRadius.circular(10),
// //           child: Container(
// //             width: 300,
// //             height: 200,
// //             child: _image,
// //           ),
// //         ),
// //         SizedBox(height: 14),
// //         Text(
// //           _name,
// //           style: Helper.getTheme(context)
// //               .headline4
// //               ?.copyWith(color: AppColor.primary),
// //         ),
// //         Row(
// //           children: [
// //             Text("Cafe"),
// //             SizedBox(
// //               width: 5,
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.only(bottom: 5.0),
// //               child: Text(
// //                 ".",
// //                 style: TextStyle(
// //                   color: AppColor.orange,
// //                   fontWeight: FontWeight.w900,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               width: 5,
// //             ),
// //             Text("Western Food"),
// //             SizedBox(
// //               width: 20,
// //             ),
// //             Image.asset(
// //               Helper.getAssetName("star_filled.png", "virtual"),
// //             ),
// //             SizedBox(
// //               width: 5,
// //             ),
// //             Text(
// //               "4.9",
// //               style: TextStyle(
// //                 color: AppColor.orange,
// //               ),
// //             )
// //           ],
// //         )
// //       ],
// //     );
// //   }
// // }

// // class RestaurantCard extends StatelessWidget {
// //   const RestaurantCard({
// //     Key? key,
// //     required String name,
// //     required Image image,
// //   })  : _image = image,
// //         _name = name,
// //         super(key: key);

// //   final String _name;
// //   final Image _image;

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       height: 270,
// //       width: double.infinity,
// //       child: Column(
// //         children: [
// //           SizedBox(height: 200, width: double.infinity, child: _image),
// //           SizedBox(
// //             height: 10,
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(
// //               horizontal: 20,
// //             ),
// //             child: Column(
// //               children: [
// //                 Row(
// //                   children: [
// //                     Text(
// //                       _name,
// //                       style: Helper.getTheme(context).headline3,
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(
// //                   height: 5,
// //                 ),
// //                 Row(
// //                   children: [
// //                     Image.asset(
// //                       Helper.getAssetName("star_filled.png", "virtual"),
// //                     ),
// //                     SizedBox(
// //                       width: 5,
// //                     ),
// //                     Text(
// //                       "4.9",
// //                       style: TextStyle(
// //                         color: AppColor.orange,
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       width: 5,
// //                     ),
// //                     Text("(124 ratings)"),
// //                     SizedBox(
// //                       width: 5,
// //                     ),
// //                     Text("Cafe"),
// //                     SizedBox(
// //                       width: 5,
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.only(bottom: 5.0),
// //                       child: Text(
// //                         ".",
// //                         style: TextStyle(
// //                           color: AppColor.orange,
// //                           fontWeight: FontWeight.w900,
// //                         ),
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       width: 5,
// //                     ),
// //                     Text("Western Food"),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class CategoryCard extends StatelessWidget {
// //   const CategoryCard({
// //     Key? key,
// //     required Image image,
// //     required String name,
// //   })  : _image = image,
// //         _name = name,
// //         super(key: key);

// //   final String _name;
// //   final Image _image;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         ClipRRect(
// //           borderRadius: BorderRadius.circular(10),
// //           child: Container(
// //             width: 100,
// //             height: 100,
// //             child: _image,
// //           ),
// //         ),
// //         SizedBox(
// //           height: 5,
// //         ),
// //         Text(
// //           _name,
// //           style: Helper.getTheme(context)
// //               .headline4
// //               ?.copyWith(color: AppColor.primary, fontSize: 16),
// //         ),
// //       ],
// //     );
// //   }
// // }
