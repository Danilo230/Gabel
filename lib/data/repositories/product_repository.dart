import '../../presentation/screens/products/models/productmodel.dart';

class ProductRepository {
  final dynamic client;

  ProductRepository({this.client});

  Future<List<ProductModel>> getProducts() async {
    final response = await client.get('Products');
    final List<dynamic> data = response.data;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await client.get('Products/$id');
    return ProductModel.fromJson(response.data);
  }

  // Ahora recibe ProductModel directamente
  Future<ProductModel> createProduct(ProductModel product) async {
    final response = await client.post('Products', data: product.toJson());
    return ProductModel.fromJson(response.data);
  }

  Future<void> updateProduct(int id, ProductModel product) async {
    await client.put('Products/$id', data: product.toJson());
  }

  Future<void> deleteProduct(int id) async {
    await client.delete('Products/$id');
  }
}
