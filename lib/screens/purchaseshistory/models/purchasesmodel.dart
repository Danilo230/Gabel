class Purchase {
  final String supplierName;
  final String purchaseDate;
  final double totalAmount;

  const Purchase({
    required this.supplierName,
    required this.purchaseDate,
    required this.totalAmount,
  });
}

class PurchaseDetail {
  final String? productName;
  final int purchaseQuantity;
  final double unitPrice;
  final double lineTotal;

  const PurchaseDetail({
    this.productName,
    required this.purchaseQuantity,
    required this.unitPrice,
    required this.lineTotal,
  });
}