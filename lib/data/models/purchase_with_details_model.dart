import 'purchase_detail_model.dart';

class PurchaseWithDetailsModel {
  final int purchaseId;
  final String supplierName;
  final DateTime purchaseDate;
  final double totalAmount;
  final List<PurchaseDetailModel> details;

  const PurchaseWithDetailsModel({
    required this.purchaseId,
    required this.supplierName,
    required this.purchaseDate,
    required this.totalAmount,
    required this.details,
  });

  static PurchaseWithDetailsModel fromJson(Map<String, dynamic> json) {
    return PurchaseWithDetailsModel(
      purchaseId: json['purchaseId'] as int,
      supplierName: json['supplierName'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      details: (json['details'] as List<dynamic>)
          .map((e) => PurchaseDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}