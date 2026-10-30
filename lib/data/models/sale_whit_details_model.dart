import 'package:gabel/data/models/sale_detail_model.dart';

class SaleWhitDetailsModel {
  final int saleId;
  final DateTime saleDate;
  final double totalPrice;
  final String customerName;
  final List<SaleDetailModel> details;

    const SaleWhitDetailsModel({
    required this.saleId,
    required this.saleDate,
    required this.totalPrice,
    required this.customerName,
    required this.details,
  });

  static SaleWhitDetailsModel fromJson(Map<String, dynamic> json) {
    return SaleWhitDetailsModel(
      saleId: json['saleId'] as int,
      saleDate: DateTime.parse(json['saleDate'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      customerName: json['customerName'] as String,
      details: (json['details'] as List<dynamic>)
          .map((e) => SaleDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

}