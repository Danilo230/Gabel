class ProductModel {
  final int productId;
  final String productName;
  final String productDescription;
  final String productBrand;
  final String productUnit;
  final String productCategory;
  final String productSupplier;
  final bool productStatus;

  const ProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productBrand,
    required this.productUnit,
    required this.productCategory,
    required this.productSupplier,
    required this.productStatus,
  });

  
  static ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: (json['productId'] as num).toInt(),
      productName: json['productName'] as String? ?? '',
      productDescription: json['productDescription'] as String? ?? '',
      productBrand: json['brand'] as String? ?? '',
      productUnit: json['unitName'] as String? ?? '',
      productCategory: json['categoryName'] as String? ?? '',
      productSupplier: json['supplierName'] as String? ?? '',
      productStatus: json['productStatus'] as bool? ?? false,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'productBrand': productBrand,
      'productUnit': productUnit,
      'productCategory': productCategory,
      'productSupplier': productSupplier,
      'productStatus': productStatus,
    };
  }
}
