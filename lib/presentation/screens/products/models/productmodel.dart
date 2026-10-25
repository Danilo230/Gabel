class Product {
  final String productName;
  final String productDescription;
  final String productBrand;
  final String productUnit;
  final String productCategory;
  final String productSupplier;
  final String productPrice;
  final String productStatus;

  const Product({
    required this.productName,
    required this.productDescription,
    required this.productBrand,
    required this.productUnit,
    required this.productCategory,
    required this.productSupplier,
    required this.productPrice,
    required this.productStatus,
  });

  static const List<String> units = [
    'Unidad',
    'Litro',
    'Mililitro',
    'kilogramo',
  ];
  static const List<String> categories = ['Seleccionar categoria', 'Alisado'];
  static const List<String> suppliers = [
    'Seleccionar proveedor',
    'Distribuidora Central',
    'Laboratorios Belleza S.A.',
    'Proveedor Nacional',
    'Cosméticos Global',
  ];

  static const List<String> brands = [
    'Seleccionar marca',
    'Sedal',
    'Pantene',
    'Garnier',
    'Head & Shoulders',
  ];
  static const List<String> statuses = ['Activo', 'Inactivo'];
}
