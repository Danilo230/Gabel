class PurchaseModel {
  final int purchaseId;
  final String supplierName;
  final DateTime purchaseDate;
  final double totalAmount;

  const PurchaseModel({
    required this.purchaseId,
    required this.supplierName,
    required this.purchaseDate,
    required this.totalAmount
  });

  static PurchaseModel fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      purchaseId: json['purchasesId'] as int,
      supplierName: json['suppliersName'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble()
    );
  }
}