class Cart {
  final String id;
  final String pName;
  double pPrice;
  final String pCategory;
  final String pDescription;
  final String pImage;
  double pQuantity;

  Cart({
    required this.id,
    required this.pName,
    required this.pPrice,
    required this.pCategory,
    required this.pDescription,
    required this.pImage,
    required this.pQuantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json, String documentId) {
    return Cart(
      id: documentId,
      pName: json['pName'] ?? '',
      pCategory: json['pCategory'] ?? '',
      pPrice: json['pPrice'] ?? 0.0,
      pDescription: json['pDescription'] ?? '',
      pImage: json['pImage'] ?? '',
      pQuantity: json['pQuantity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pImage": pImage,
      "pName": pName,
      "pPrice": pPrice,
      "pDescription": pDescription,
      "pQuantity": pQuantity,
      "pCategory": pCategory,
    };
  }
  Map<String, dynamic> toMap() {
    return {
      'pImage': pImage,
      'pName': pName,
      'pPrice': pPrice,
      'pQuantity': pQuantity,
    };
  }

  void updateQuantity(double newQuantity) {
    pQuantity = newQuantity;
  }

  void updatePrice(double newPrice) {
    pPrice = newPrice;
  }

  static double calculateTotalPrice(List<Cart> cartItems) {
    double totalPrice = 0;

    for (var item in cartItems) {
      totalPrice += item.pPrice *item.pQuantity ;
    }

    return totalPrice;
  }
}
