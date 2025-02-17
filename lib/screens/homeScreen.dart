// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, unused_field, file_names, unused_element, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madproject/modles/cart_model.dart';
import 'package:madproject/modles/categories_model.dart';
import 'package:madproject/modles/items_model.dart';
import 'package:madproject/screens/addToCartDialog.dart';
import 'package:madproject/screens/cartScreen.dart';
import 'package:madproject/services/firebase_services.dart';
import 'package:madproject/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/colors.dart';
import '../utils/helper.dart';
import '../widgets/customNavBar.dart';
import '../screens/individualItem.dart';
import '../widgets/searchBar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController = PageController(initialPage: 0);
  late PageController _menuController;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  final Services _firestoreService = Services();
  int _selectedIndex = 0;

  late User? _user;
  String? _displayName;
  late List<Category> menuCategories = []; // List to store categories
  final Map<String, List<Map<String, dynamic>>> menuItems =
      {}; // Map to store items per category

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _pageController = PageController(initialPage: _selectedIndex);
    _menuController = PageController(initialPage: _selectedIndex);
    _fetchCategoriesAndItems(); // Fetch categories and items on initialization
  }

  @override
  void dispose() {
    _pageController.dispose();
    _menuController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCategoriesAndItems() async {
    List<Category> categories = await _firestoreService.getCategories();
    setState(() {
      menuCategories = categories;
    });
    // Fetch items for each category
    for (Category category in menuCategories) {
      if (category.name.isNotEmpty) {
        String categoryName = category.name;
        List<Map<String, dynamic>> items =
            await _firestoreService.getItemsByCategory(categoryName);

        setState(() {
          menuItems[categoryName] = items;
        });
      }
    }
  }

  void _addToFavorites(Map<String, dynamic> item) {
    if (_user != null && item.isNotEmpty) {
      String userId = _user!.uid;
      _firestoreService.addToFavorites(userId, item);
      // Optionally, you can show a message or perform other actions after adding to favorites
      showToast(message: "Added to Favorites");
    } else {
      // Handle if the user is not authenticated or other conditions
      showToast(message: "Please sign in to add to Favorites");
    }
  }

  void addToCart(Map<String, dynamic> item) {
    double price = double.parse(item['pPrice'].toString());
    Cart cart = Cart(
      id: '',
      pName: item['pName'],
      pPrice: price,
      pCategory: item['pCategory'],
      pDescription: item['pDescription'],
      pImage: item['pImage'],
      pQuantity: 1,
    );

    // // Call the function to add this item to the cart
    _firestoreService.addItemsToCart(cart);
  }

  //shared prefrences function
  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (user != null) {
      // User is signed in
      setState(() {
        _user = user;
      });

      // Retrieve the user's display name from SharedPreferences
      String? displayName = prefs.getString('displayName');

      if (displayName != null) {
        setState(() {
          _displayName = displayName;
        });
      } else {
        // If display name is not found in SharedPreferences, fetch it from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('userData')
            .doc(user.uid)
            .get();

        displayName = userDoc.get('name');

        // Save the display name to SharedPreferences
        await prefs.setString('displayName', displayName!);

        setState(() {
          _displayName = displayName;
        });
      }
    }
  }

  Future<void> _searchProducts(String searchTerm) async {
    List<Map<String, dynamic>> results =
        await _firestoreService.searchProductsByName(searchTerm);

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              color: Colors.deepOrange,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Welcome $_displayName",
                      style: Helper.getTheme(context).headline5?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.routeName);
                      },
                      child: Image.asset(
                        Helper.getAssetName("cart_white.png", "virtual"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Searchbar(
            //   title: "Search Food",
            //   onSearch: _searchProducts,
            // ),
            Align(
              alignment: Alignment.center + Alignment(0.0, 0.2),
              child: SizedBox(
                width: 100, // Specify the width
                height: 100, // Specify the height
                child: Image.asset(
                  Helper.getAssetName("logo.png", "virtual"),
                  fit: BoxFit
                      .contain, // Adjusts the image to fit within the size constraints
                ),
              ),
            ),

            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _menuController,
              child: Row(
                children: menuCategories.map((category) {
                  int index = menuCategories.indexOf(category);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        category.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: _selectedIndex == index
                              ? Colors.deepOrange
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                itemCount: menuCategories.length,
                itemBuilder: (context, index) {
                  final category = menuCategories[index];
                  final items = menuItems[category.name];
                  return ListView.builder(
                    itemCount: items?.length ?? 0,
                    itemBuilder: (context, itemIndex) {
                      final item = items?[itemIndex];
                      return _buildItemsList(item!);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(home: true),
    );
  }

  Widget _buildItemsList(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Handle item tap here
          _navigateToItemDetails(item);
        },
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  child: Image.asset(
                    Helper.getAssetName(
                      item['pImage'].toString(),
                      "real",
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['pName'],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(item['pDescription']),
                      SizedBox(height: 4.0),
                      Text(
                        item['pPrice'].toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              addToCart(item);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 5, right: 10, bottom: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Add',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              _addToFavorites(
                                  item); // Call function to add item to favorites
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToItemDetails(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IndividualItem(
          itemCategory: item['pCategory'],
          itemName: item['pName'],
          itemDescription: item['pDescription'],
          itemPrice: item['pPrice'].toString(),
          itemImage: item['pImage'].toString(),
        ),
      ),
    );
  }
}
