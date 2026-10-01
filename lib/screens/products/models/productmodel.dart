class Product {
  final String name;
  final String description;
  final String brand;
  final String unitOfMeasure;
  final String category;
  final String supplier;
  final String price;
  final String status;

  const Product({
    required this.name,
    this.description = '',
    this.brand = '',
    this.unitOfMeasure = '',
    this.category = '',
    this.supplier = '',
    required this.price,
    this.status = 'Activo',
  });
}