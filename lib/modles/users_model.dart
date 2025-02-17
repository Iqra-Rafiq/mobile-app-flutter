import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String uid;
  final String email;
  final String mobileNo;
  final String name;
  late String address;

  UserData({
    required this.uid,
    required this.email,
    required this.mobileNo,
    required this.name,
    this.address = '',
  });

  factory UserData.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> data = snapshot.data()!;
    return UserData(
      name: data['name'],
      mobileNo: data['mobileNo'],
      uid: data['uid'],
      email: data['email'],
      address: data['address'],
    );
  }

  factory UserData.fromJson(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return UserData(
      uid: documentId,
      email: json['email'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'mobileNo': mobileNo,
      'name': name,
      'address': address,
    };
  }
}
