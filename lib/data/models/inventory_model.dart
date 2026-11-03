class InventoryModel {
  final int inventoryId;
  final int productId;
  final String productName;
  final double stock;
  final double unitPrice;
  final double salePrice;
  final int damagedStock;

  const InventoryModel({
    required this.inventoryId,
    required this.productId,
    required this.productName,
    required this.stock,
    required this.unitPrice,
    required this.salePrice,
    required this.damagedStock,
  });

    static InventoryModel fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      inventoryId: json['inventoryId'] as int,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      stock: (json['stock'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      damagedStock: (json['damagedStock'] as num).toInt(),
    );
  }
}
