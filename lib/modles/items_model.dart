class Item {
  final String pId;
  final String pName;
  final double pPrice;
  final String pCategory;
  final String pDescription;
  final String pImage;

  Item(
      {required this.pId,
      required this.pName,
      required this.pPrice,
      required this.pCategory,
      required this.pDescription,
      required this.pImage,
      });

  factory Item.fromJson(Map<String, dynamic> json, String documentId) {
    return Item(
      pId: documentId,
      pName: json['pName'] ?? '',
      pCategory: json['pCategory'] ?? '',
      pPrice: json['pPrice'] ?? 0.0,
      pDescription: json['pDescription'] ?? '',
      pImage: json['pImage'] ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pName': pName,
      'pPrice': pPrice,
      'pCategory': pCategory,
      'pDescription': pDescription,
      'pImage': pImage,
    };
  }
}
