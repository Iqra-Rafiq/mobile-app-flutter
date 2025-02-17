// import 'package:cloud_firestore/cloud_firestore.dart';

// class Orders {
//   //final String orderId;
//   final String userId;
//   final int totalPrice;
//   final Timestamp date;

//   Orders({
//     //required this.orderId,
//     required this.userId,
//     required this.totalPrice,
//     required this.date,
//   });

//   // Convert order data to a map
//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'totalPrice': totalPrice,
//       'date': date,
//     };
//   }

//   // Create Order object from a map
//   factory Orders.fromJson(Map<String, dynamic> map) {
//     return Orders(
//       //orderId: documentId,
//       userId: map['userId'],
//       totalPrice: map['totalPrice'],
//       date: map['date'],
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  final String orderId;
  final String userId;
  final double totalPrice;
  final Timestamp date;

  Orders({
    required this.orderId,
    required this.userId,
    required this.totalPrice,
    required this.date,
  });

  // Convert order data to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'totalPrice': totalPrice,
      'date': date,
    };
  }

  // Create Order object from a map
  factory Orders.fromJson(Map<String, dynamic> map, String documentId) {
    return Orders(
      orderId: documentId,
      userId: map['userId'],
      totalPrice: map['totalPrice'],
      date: map['date'],
    );
  }
}