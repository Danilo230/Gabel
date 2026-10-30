class SalesModel {
  final int saleId;
  final DateTime saleDate;
  final double totalPrice;
  final String customerName;

  const SalesModel({
    required this.saleId,
    required this.saleDate,
    required this.totalPrice,
    required this.customerName
  });

  static SalesModel fromJson(Map<String, dynamic> json) {
    return SalesModel(
      saleId: json['saleId'] as int,
      saleDate: DateTime.parse(json['saleDate'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      customerName: json['customerName'] as String
    );
  }

}