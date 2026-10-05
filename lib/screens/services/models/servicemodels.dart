class Service {
  final String name;
  final String price;
  final String category;
  final String product;
  final String status;
  final String description;

  const Service({
    required this.name,
    required this.price,
    this.category = '',
    this.product = '',
    this.status = '',
    this.description = '',
  });


}