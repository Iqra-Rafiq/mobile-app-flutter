class OrderItem {
  final String orderId;
  final String pImage;
  final String pName;
  final double pPrice;
  final double pQuantity;

  OrderItem({
    required this.orderId,
    required this.pImage,
    required this.pName,
    required this.pPrice,
    required this.pQuantity,
  });

  // Convert order item data to a map
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'pImage': pImage,
      'pName': pName,
      'pPrice': pPrice,
      'pQuantity': pQuantity,
    };
  }

  // Create OrderItem object from a map
  factory OrderItem.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('No data found for OrderItem');
    }
    return OrderItem(
      orderId: map['orderId'],
      pImage: map['pImage'],
      pName: map['pName'],
      pPrice: map['pPrice'],
      pQuantity: map['pQuantity'],
    );
  }
}