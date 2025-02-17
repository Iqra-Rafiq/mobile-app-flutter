// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, unused_import, file_names

import 'package:flutter/material.dart';
import 'package:madproject/modles/cart_model.dart';
import 'package:madproject/screens/checkoutScreen.dart';
import 'package:madproject/screens/homeScreen.dart';
import 'package:madproject/services/firebase_services.dart';
import 'package:madproject/utils/helper.dart';
import 'package:madproject/widgets/toast.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> cartItems = []; // List to hold cart items
  final Services _firestoreService = Services();

  @override
  void initState() {
    super.initState();
    fetchCartItems(); // Fetch cart items from Firebase on screen initialization
  }

  Future<void> fetchCartItems() async {
    List<Cart> items = await _firestoreService.getItemsFromCart();
    setState(() {
      cartItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
        ),
        body: cartItems.isEmpty
            ? Center(
                child: Text('No items in cart'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        double quantity = cartItems[index].pQuantity;
                        double price = cartItems[index].pPrice * quantity;

                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            leading: Image.asset(
                              Helper.getAssetName(
                                cartItems[index].pImage,
                                "real",
                              ),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(cartItems[index].pName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cartItems[index].pDescription),
                                Text(
                                  'Price: \$${price.toStringAsFixed(2)}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () async {
                                    if (cartItems[index].pQuantity > 0) {
                                      setState(() {
                                        cartItems[index].updateQuantity(
                                          cartItems[index].pQuantity - 1,
                                        );
                                        // Update the price when quantity changes
                                        if (cartItems[index].pQuantity != 0) {
                                          price = cartItems[index].pPrice *
                                              cartItems[index].pQuantity;
                                        } else {
                                          price =
                                              0; // Set price to 0 if quantity is 0
                                        }
                                      });
                                      await _firestoreService.updateCartItem(
                                        cartItems[index].id,
                                        cartItems[index].pQuantity,
                                        price,
                                      );

                                      if (cartItems[index].pQuantity == 0) {
                                        // Remove item from Firestore database
                                        await _firestoreService.deleteCartItem(
                                          cartItems[index].id,
                                        );

                                        // Remove item from cart after Firestore update
                                        setState(() {
                                          cartItems.removeAt(index);
                                        });
                                      }
                                    }
                                  },
                                ),
                                Text(cartItems[index].pQuantity.toString()),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () async {
                                    setState(() {
                                      cartItems[index].updateQuantity(
                                        cartItems[index].pQuantity + 1,
                                      );
                                      // Update the price when quantity changes
                                      price = cartItems[index].pPrice *
                                          cartItems[index].pQuantity;
                                    });
                                    await _firestoreService.updateCartItem(
                                      cartItems[index].id,
                                      cartItems[index].pQuantity,
                                      price,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutScreen()));
                    },
                    child: Text('Proceed to Checkout'),
                  ),
                ],
              ),
      ),
    );
  }
}
