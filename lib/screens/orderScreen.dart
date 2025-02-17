// ignore_for_file: use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:madproject/modles/orderItem_model.dart';
import 'package:madproject/modles/orders_model.dart';
import 'package:madproject/services/firebase_services.dart';

class orderScreen extends StatefulWidget {
  static const routeName = "/orderScreen";

  @override
  _orderScreenState createState() => _orderScreenState();
}

class _orderScreenState extends State<orderScreen> {
  List<Orders> orders = [];
  Map<String, List<OrderItem>> orderItemsMap = {};
  final Services _firestoreService = Services();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    List<Orders> previousOrders = await _firestoreService.getOrders();
    setState(() {
      orders = previousOrders;
    });
  }

  Future<void> fetchOrderItems(String orderId) async {
    List<OrderItem> previousOrderItems =
        await _firestoreService.getOrderItems(orderId);
    setState(() {
      orderItemsMap[orderId] = previousOrderItems;
    });
  }

 @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: SafeArea(
        child: orders.isEmpty
            ? Center(
                child: Text('No previous orders found.'),
              )
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  var order = orders[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ExpansionTile(
                      title: Text('Order # ${order.orderId}'),
                      subtitle: Text('Total Price: \$${order.totalPrice}'),
                      children: orderItemsMap.containsKey(order.orderId)
                          ? orderItemsMap[order.orderId]!
                              .map(
                                (item) => ListTile(
                                  title: Text(item.pName),
                                  subtitle: Text('Quantity: ${item.pQuantity}'),
                                ),
                              )
                              .toList()
                          : [
                              FutureBuilder<void>(
                                future: fetchOrderItems(order.orderId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error fetching data'),
                                      );
                                    } else {
                                      return Column(
                                        children: orderItemsMap[order.orderId]!
                                            .map(
                                              (item) => ListTile(
                                                title: Text(item.pName),
                                                subtitle: Text(
                                                    'Quantity: ${item.pQuantity}'),
                                              ),
                                            )
                                            .toList(),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                      onExpansionChanged: (expanded) {
                        if (expanded) {
                          fetchOrderItems(order.orderId);
                        }
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}