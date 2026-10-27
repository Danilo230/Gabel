class ProductModel {
  final int productId;
  final String productName;
  final String productDescription;
  final String productBrand;
  final String productUnit;
  final String productCategory;
  final String productSupplier;
  final String productPrice;
  final bool productStatus;

  const ProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productBrand,
    required this.productUnit,
    required this.productCategory,
    required this.productSupplier,
    required this.productPrice,
    required this.productStatus,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      productDescription: json['productDescription'] as String,
      productBrand: json['productBrand'] as String,
      productUnit: json['productUnit'] as String,
      productCategory: json['productCategory'] as String,
      productSupplier: json['productSupplier'] as String,
      productPrice: json['productPrice'] as String,
      productStatus: json['productStatus'] as bool,
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
      'productPrice': productPrice,
      'productStatus': productStatus,
    };
  }
}
