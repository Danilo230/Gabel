// modelo de producto para el inventario

class Product {
  final String name;
  final String category;
  final bool isActive;
  final int stock;
  final int damagedStock;
  final double salePrice;
  final double purchasePrice;
  final int margin;
  final String lastPurchase;

  const Product({
    required this.name,
    required this.stock,
    required this.salePrice,
    this.category = 'Cuidado Capilar',
    this.isActive = true,
    this.damagedStock = 0,
    this.purchasePrice = 0,
    this.margin = 0,
    this.lastPurchase = '',
  });

  bool get isLowStock => stock <= 5;
}
