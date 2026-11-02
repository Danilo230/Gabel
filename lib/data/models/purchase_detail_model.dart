class PurchaseDetailModel {
  final String? productName;
  final int purchaseQuantity;
  final double unitPrice;
  final double totalAmount;

  const PurchaseDetailModel({
    required this.productName,
    required this.purchaseQuantity,
    required this.unitPrice,
    required this.totalAmount,
  });

  static PurchaseDetailModel fromJson(Map<String, dynamic> json) {
    return PurchaseDetailModel(
      productName: json['productName'] as String?,
      purchaseQuantity: (json['purchaseQuantity'] as num).toInt(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );
  }
}