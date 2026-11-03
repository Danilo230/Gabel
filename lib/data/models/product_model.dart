class ProductModel {
  final int productId;
  final String productName;
  final String productDescription;
  final String brand;
  final bool productStatus;
  final int unitId;
  final String unitName;
  final int categoryId;
  final String categoryName;
  final int supplierId;
  final String supplierName;

  const ProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.brand,
    required this.productStatus,
    required this.unitName,
    required this.categoryName,
    required this.supplierName,
    this.unitId = 0,
    this.categoryId = 0,
    this.supplierId = 0,
  });

  static ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] as int? ?? 0,
      productName: json['productName'] as String? ?? '',
      productDescription: json['productDescription'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      productStatus: json['productStatus'] as bool? ?? true,
      unitId: json['unitId'] as int? ?? 0,
      unitName: json['unitName'] as String? ?? '',
      categoryId: json['categoryId'] as int? ?? 0,
      categoryName: json['categoryName'] as String? ?? '',
      supplierId: json['supplierId'] as int? ?? 0,
      supplierName: json['supplierName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'brand': brand,
      'productStatus': productStatus,
      'unitId': unitId,
      'unitName': unitName,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'supplierId': supplierId,
      'supplierName': supplierName,
    };
  }
}

class CatalogItem {
  final int id;
  final String name;

  const CatalogItem({required this.id, required this.name});
}
