class SaleDetail {
  final String itemType;
  final String? productName;
  final String? serviceName;
  final int saleQuantity;
  final double salePrice;
  final double lineTotal;

  const SaleDetail({
    required this.itemType,
    this.productName,
    this.serviceName,
    required this.saleQuantity,
    required this.salePrice,
    required this.lineTotal,
  });

  String get itemName {
    if (itemType == 'PRODUCT') {
      return productName ?? 'Producto';
    }

    return serviceName ?? 'Servicio';
  }
}