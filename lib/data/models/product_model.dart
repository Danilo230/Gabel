class ProductModel {
  final int productId;
  final String productName;
  final String productDescription;
  final String brand;
  final String unitName;
  final String categoryName;
  final String supplierName;
  final bool productStatus;

  const ProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.brand,
    required this.unitName,
    required this.categoryName,
    required this.supplierName,
    required this.productStatus,
  });

  static ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      productDescription: (json['productDescription'] ?? '') as String,
      brand: (json['brand'] ?? '') as String,
      unitName: (json['unitName'] ?? '') as String,
      categoryName: (json['categoryName'] ?? '') as String,
      supplierName: (json['supplierName'] ?? '') as String,
      productStatus: json['productStatus'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'brand': brand,
      'unitName': unitName,
      'categoryName': categoryName,
      'supplierName': supplierName,
      'productStatus': productStatus,
    };
  }

  ProductModel copyWith({
    int? productId,
    String? productName,
    String? productDescription,
    String? brand,
    String? unitName,
    String? categoryName,
    String? supplierName,
    bool? productStatus,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      brand: brand ?? this.brand,
      unitName: unitName ?? this.unitName,
      categoryName: categoryName ?? this.categoryName,
      supplierName: supplierName ?? this.supplierName,
      productStatus: productStatus ?? this.productStatus,
    );
  }
}
