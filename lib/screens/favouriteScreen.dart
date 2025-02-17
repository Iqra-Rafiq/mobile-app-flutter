// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:madproject/services/firebase_services.dart';
import 'package:madproject/utils/helper.dart'; // Replace with your service file import

class FavoriteScreen extends StatefulWidget {
  static const routeName = "/favoriteScreen";

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> favoriteItems = []; // Initialize an empty list
  Services firebaseService = Services();
  @override
  void initState() {
    super.initState();
    fetchFavoriteItems(); // Call the function to fetch favorite items
  }

  Future<void> fetchFavoriteItems() async {
    // Call the service method to get favorite items
    List<Map<String, dynamic>> fetchedItems = await firebaseService.getFavoriteItems();

    setState(() {
      favoriteItems = fetchedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Items'),
      ),
      body: favoriteItems.isEmpty
          ? Center(
              child: Text('No favorite items yet.'),
            )
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return ListTile(
                  leading: Image.asset(
                    Helper.getAssetName(
                      item['pImage'].toString(),
                      "real",
                    ),
                    fit: BoxFit.contain,
                  ),
                  title: Text(item['pName'].toString()),
                  subtitle: Text(item['pDescription'].toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.edit_attributes_rounded),
                    onPressed: () {
                      // Remove the item from favorites
                      removeFavorite(index);
                    },
                  ),
                );
              },
            ),
    );
  }

  void removeFavorite(int index) async {
  // Implement logic to remove the item from favorites list and update the UI
  if (index >= 0 && index < favoriteItems.length) {
    // Get the item to be removed
    Map<String, dynamic> removedItem = favoriteItems[index];

    // Remove the item from the list
    setState(() {
      favoriteItems.removeAt(index);
    });

    // Call the service method to remove the item from the database
    await firebaseService.removeFromFavorites(removedItem['pId']); 
  }
}

}
