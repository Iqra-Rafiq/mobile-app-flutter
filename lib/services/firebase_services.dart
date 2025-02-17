// ignore_for_file: unused_import, unused_local_variable, avoid_print, use_rethrow_when_possible, unused_element

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:madproject/modles/cart_model.dart';
import 'package:madproject/modles/categories_model.dart';
import 'package:madproject/modles/items_model.dart';
import 'package:madproject/modles/users_model.dart';
import 'package:madproject/widgets/toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:madproject/modles/orders_model.dart';
import 'package:madproject/modles/orderItem_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all categories
  Future<List<Category>> getCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('categories').get();
      return querySnapshot.docs
          .map((doc) =>
              Category.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      showToast(message: 'Error fetching categories: $e');
      return [];
    }
  }

  // Get items by category name
  Future<List<Map<String, dynamic>>> getItemsByCategory(String category) async {
    try {
      QuerySnapshot itemsSnapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('pCategory',
              isEqualTo: category) // Match 'pcategory' with category
          .get();

      List<Map<String, dynamic>> items = itemsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return items;
    } catch (e) {
      showToast(message: 'Error fetching items: $e');
      return [];
    }
  }

  //add items to Cart
  Future<void> addItemsToCart(Cart cart) async {
    try {
      // Check if the item already exists in the user's cart
      final existingItem = await FirebaseFirestore.instance
          .collection("cart")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userCart")
          .where("pName",
              isEqualTo: cart.pName) // Change this to your unique identifier
          .get();

      if (existingItem.docs.isNotEmpty) {
        // Item already exists, update the quantity
        final existingItemId = existingItem.docs[0].id;
        final existingItemQuantity = existingItem.docs[0]["pQuantity"];

        await FirebaseFirestore.instance
            .collection("cart")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userCart")
            .doc(existingItemId)
            .update({
          "pQuantity": existingItemQuantity + cart.pQuantity,
        });
      } else {
        // Item doesn't exist, add it to the cart
        await FirebaseFirestore.instance
            .collection("cart")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userCart")
            .add(
          {
            "pImage": cart.pImage,
            "pName": cart.pName,
            "pPrice": cart.pPrice,
            "pDescription": cart.pDescription,
            "pQuantity": cart.pQuantity,
            "pCategory": cart.pCategory,
          },
        );
      }

      showToast(message: "Item Added to Cart");
    } catch (e) {
      // Show a toast message
      showToast(message: 'Error adding item to Firebase: $e');
    }
  }

  // Fetch items from the user's cart collection
  Future<List<Cart>> getItemsFromCart() async {
    List<Cart> cartItems = [];

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot querySnapshot = await _firestore
          .collection('cart')
          .doc(userId)
          .collection('userCart')
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Cart cart = Cart.fromJson(data, doc.id);
        cartItems.add(cart);
      }
    } catch (e) {
      // Handle errors
      showToast(message: 'Error fetching items from cart: $e');
    }

    return cartItems;
  }

  //update cart quantity
  Future<void> updateCartItem(
      String cartItemId, double newQuantity, double newPrice) async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('userCart')
        .doc(cartItemId)
        .update({
      'pQuantity': newQuantity,
      'pPrice': newPrice,
    });
  }

  //delete cart item
  Future<void> deleteCartItem(String itemId) async {
    try {
      await _firestore
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userCart')
          .doc(itemId)
          .delete();
      //showToast(message: 'Item deleted successfully');
    } catch (e) {
      showToast(message: 'Error deleting item from Firestore: $e');
      // Handle error as needed
    }
  }

  Future<void> fetchAndSaveAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address =
            "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        await saveUserAddress(address);
      }
    } catch (e) {
      showToast(message: "Error fetching and saving address: $e");
    }
  }

  Future<void> saveUserAddress(String address) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Implement the logic to save the user's address to your database
      FirebaseFirestore.instance
          .collection('userData')
          .doc(user.uid)
          .update({'address': address});
    }
  }

  Future<void> fetchUserLocationAndUpdateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    PermissionStatus permissionStatus = await Permission.location.request();

    // Check the permission status
    if (permissionStatus.isGranted) {
      if (user != null) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        double latitude = position.latitude;
        double longitude = position.longitude;
        await fetchAndSaveAddressFromCoordinates(latitude, longitude);
      }
    } else {
      showToast(message: "permission denied");
      String address = "";
      await saveUserAddress(address);
      // Location permission is denied or restricted
      // Handle the scenario where the user denies location permission
    }
  }

  Future<UserData?> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDataSnapshot =
          await FirebaseFirestore.instance
              .collection('userData')
              .doc(user.uid)
              .get();

      if (userDataSnapshot.exists) {
        return UserData.fromSnapshot(userDataSnapshot);
      } else {
        // User document does not exist
        return null;
      }
    } else {
      // User is not logged in
      return null;
    }
  }

  Future<double> getTotalBill() async {
    double totalBill = 0;

    try {
      // Fetch the user's cart items from Firestore
      QuerySnapshot cartSnapshot = await _firestore
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userCart')
          .get();

      // Calculate the total bill from the cart items
      for (var doc in cartSnapshot.docs) {
        double price = doc.get('pPrice');
        totalBill += price;
      }
    } catch (e) {
      // Handle any potential errors here
      showToast(message: 'Error fetching cart items: $e');
    }

    return totalBill;
  }

  Future<void> moveToOrder(List<Cart> cartItems) async {
    try {
      if (cartItems.isNotEmpty) {
        String orderId =
            FirebaseFirestore.instance.collection('orders').doc().id;

        DocumentReference orderRef = await _firestore.collection('orders').add(
              Orders(
                userId: FirebaseAuth.instance.currentUser!.uid,
                orderId: orderId, // Use the locally generated ID for orderId
                totalPrice: Cart.calculateTotalPrice(cartItems),
                date: Timestamp.now(),
              ).toMap(),
            );
        print('Order ID: ${orderRef.id}');

        for (var cartItem in cartItems) {
          await _firestore.collection('orderItems').add(
            {
              'orderId': orderRef.id,
              ...cartItem.toMap(),
            },
          );
          showToast(message: 'Order placed successfully!');
          await deleteCartItem(cartItem.id);
        }
      }
    } catch (e) {
      print('Error placing order: $e');
      showToast(message: 'Failed to place order.');
    }
  }

  Future<List<OrderItem>> getOrderItems(String orderId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('orderItems')
        .where('orderId', isEqualTo: orderId)
        .get();

    return snapshot.docs
        .map((doc) => OrderItem.fromMap(doc.data() as Map<String, dynamic>?))
        .toList();
  }

  Future<List<Orders>> getOrders() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (snapshot.docs.isEmpty) {
        showToast(message: 'No orders found for this user.');
        return []; // Return an empty list if no orders are found
      }

      return snapshot.docs
          .map((doc) =>
              Orders.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      showToast(message: 'Error fetching orders: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<Map<String, dynamic>>> getFavoriteItems() async {
    List<Map<String, dynamic>> favoriteItems = [];

    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        QuerySnapshot favoritesSnapshot = await _firestore
            .collection('favourite')
            .doc(currentUser.uid)
            .collection('userfavourite')
            .get();

        // Process the data retrieved from Firestore
        favoriteItems = favoritesSnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
      }
    } catch (error) {
      print('Error fetching favorite items: $error');
      // Handle error according to your app's requirements
    }

    return favoriteItems;
  }

  Future<void> removeFromFavorites(String itemId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
            .collection('favourite')
            .doc(user.uid)
            .collection('userfavourite')
            .where('pId', isEqualTo: itemId)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          String documentId = querySnapshot.docs.first.id;
          await _firestore
              .collection('favourite')
              .doc(user.uid)
              .collection('userfavourite')
              .doc(documentId)
              .delete();
        }
      }
    } catch (error) {
      print('Error removing item from favorites: $error');
      throw error;
    }
  }

  //search the product
  Future<List<Map<String, dynamic>>> searchProductsByName(
      String searchTerm) async {
    List<Map<String, dynamic>> results = [];

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('products')
          .where('pName', isEqualTo: searchTerm)
          .get();

      results = querySnapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data;
      }).toList();
    } catch (e) {
      print("Error searching products: $e");
    }

    return results;
  }

  // Function to add an item to the user's favorites list
  Future<void> addToFavorites(String userId, Map<String, dynamic> item) async {
    try {
      // Reference to the user's favorites collection in Firestore
      CollectionReference favoritesCollection = _firestore
          .collection("favourite")
          .doc(userId)
          .collection("userfavourite");

      // Query to check if the item already exists in favorites
      QuerySnapshot<Object?> existingItems = await favoritesCollection
          .where('pId', isEqualTo: item['pId'])
          .limit(1)
          .get();

      if (existingItems.docs.isEmpty) {
        // Item not found in favorites, add it
        await favoritesCollection.add(item);
      } else {
        // Item already exists in favorites, show a message or handle accordingly
        showToast(message: 'Item already in favorites.');
      }
    } catch (error) {
      // Handle error
      print('Error adding item to favorites: $error');
      showToast(message: 'Error adding item to favorites: $error');
      // You can throw an error here or handle it according to your app logic
    }
  }

  Future<void> updateUserData({
    required String? name,
    required String? email,
    required String? mobileNo,
    // required String address,
  }) async {
    try {
      showToast(message: mobileNo.toString());
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'name': name,
        'email': email,
        'mobileNo': mobileNo,
        //'address': address,
      });
    } catch (e) {
      print('Error updating user data: $e');
      throw e;
    }
  }

}
