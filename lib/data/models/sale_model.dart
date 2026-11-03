class SaleModel {
  final int saleId;
  final DateTime saleDate;
  final double totalPrice;
  final String customerName;

  const SaleModel({
    required this.saleId,
    required this.saleDate,
    required this.totalPrice,
    required this.customerName
  });

  static SaleModel fromJson(Map<String, dynamic> json) {
    return SaleModel(
      saleId: json['saleId'] as int,
      saleDate: DateTime.parse(json['saleDate'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      customerName: json['customerName'] as String
    );
  }

}