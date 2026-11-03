class SaleDetailModel {
  final String itemType;
  final String? productName;
  final String? serviceName;
  final int saleQuantity;
  final double salePrice;
  final double lineTotal;
  
  const SaleDetailModel({
    required this.itemType,
    this.productName,
    this.serviceName,
    required this.saleQuantity,
    required this.salePrice,
    required this.lineTotal,
  });

  static SaleDetailModel fromJson(Map<String, dynamic> json) {
    return SaleDetailModel(
      itemType: json['itemType'] as String,
      productName: json['productName'] as String?,
      serviceName: json['serviceName'] as String?,
      saleQuantity: (json['saleQuantity'] as num).toInt(),
      salePrice: (json['salePrice'] as num).toDouble(),
      lineTotal: (json['lineTotal'] as num).toDouble(),
    );
  }

}