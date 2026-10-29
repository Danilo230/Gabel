class DamagedProductModel {
  final int damagedProductId;
  final String productName;
  final double stock;
  final double damagedStock;
  final double quantity;
  final String damageReason;
  final DateTime damageDate;
  final String? stylistName;
  final String? message;

  const DamagedProductModel({
    required this.damagedProductId,
    required this.productName,
    required this.stock,
    required this.damagedStock,
    required this.quantity,
    required this.damageReason,
    required this.damageDate,
    this.stylistName,
    this.message,
  });

  factory DamagedProductModel.fromJson(Map<String, dynamic> json) {
    return DamagedProductModel(
      damagedProductId: json['damagedProductId'] as int,
      productName: json['productName'] as String,
      stock: (json['stock'] as num).toDouble(),
      damagedStock: (json['damagedStock'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      damageReason: json['damageReason'] as String,
      damageDate: DateTime.parse(json['damageDate'] as String),
      stylistName: json['stylistName'] as String?,
      message: json['message'] as String?,
    );
  }
}

class CreateDamagedProductModel {
  final int inventoryId;
  final int? stylistId;
  final num quantity;
  final String damageReason;

  const CreateDamagedProductModel({
    required this.inventoryId,
    required this.quantity,
    required this.damageReason,
    this.stylistId,
  });

  Map<String, dynamic> toJson() {
    return {
      'inventoryId': inventoryId,
      'stylistId': stylistId,
      'quantity': quantity,
      'damageReason': damageReason,
    };
  }
}