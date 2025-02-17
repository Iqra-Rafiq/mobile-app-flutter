// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:madproject/const/colors.dart';

class AddToCartDialog extends StatefulWidget {
  static const routeName = "/addToCartDialog";
  final String itemName;
  final String itemPrice;

  const AddToCartDialog({
    required this.itemName,
    required this.itemPrice,
  });

  @override
  _AddToCartDialogState createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
  int quantity = 1;

  @override
 Widget build(BuildContext context) {
  return AlertDialog(
    backgroundColor: AppColor.orange, // Set the background color for the dialog
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.white, width: 6), // Set border side properties
      borderRadius: BorderRadius.circular(8), // Set border radius properties
    ), // Set the background color for the dialog
    title: Container(
      width: double.infinity, // Expand container width to fill the dialog
      decoration: BoxDecoration(
        color: Colors.deepOrange, // Set the background color for the container
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0), // Apply border radius as needed
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              'Add ${widget.itemName} to Cart',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -7,
            child: Divider(
              color: Colors.white, // Set the color for the divider line
              thickness: 1.0, // Set the thickness of the divider line
            ),
          ),
        ],
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: AppColor.orange,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.deepOrange,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      'Quantity:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(color: Colors.white), // Add a line after Quantity
        SizedBox(height: 10),
        Container(
          width: double.infinity, // Expand container width to fill the dialog
          color: Colors.deepOrange, // Set the background color for the text container
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price: ${(double.parse(widget.itemPrice) * quantity).toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Divider(color: Colors.white,thickness: 1.0,), // Add a line after Total Price
      ],
    ),
    actions: [ // Add a line above actions
      TextButton(
        onPressed: () {
          // Add to cart functionality here
          Navigator.pop(context);
        },
        child: Text(
          'Add to Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}

}
