
class SupplierModel {
  final int supplierId;
  final String supplierName;
  final bool supplierStatus;
  final String supplierAddress;
  final String taxNumber;
  final String supplierPhone;

  SupplierModel({
    required this.supplierId,
    required this.supplierName,
    required this.supplierStatus,
    required this.supplierAddress,
    required this.taxNumber,
    required this.supplierPhone,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      supplierId: json['supplierId'] ?? 0,
      supplierName: json['supplierName'] ?? '',
      supplierStatus: json['supplierStatus'] ?? false,
      supplierAddress: json['supplierAddress'] ?? '',
      taxNumber: json['taxNumber'] ?? '',
      supplierPhone: json['supplierPhone'] ?? '',
    );
  }
}
