import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/product_model.dart';

class ProductRepository {
  final ApiClient _apiClient;

  ProductRepository(this._apiClient);

  Future<ProductModel> getById(int productId) async {
    final json = await _apiClient.get('${ApiConstants.products}/$productId');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return ProductModel.fromJson(json);
  }

  Future<List<ProductModel>> getAll([Map<String, String>? params]) async {
    final data = await _apiClient.get(ApiConstants.products, query: params);
    if (data == null) return [];

    List<dynamic> items = [];

    if (data is List) {
      items = data;
    } else if (data is Map<String, dynamic>) {
      final list = data['items'] ?? data['data'] ?? data['result'];
      if (list is List) {
        items = list;
      } else {
        throw ParsingException();
      }
    } else {
      throw ParsingException();
    }

    return items
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<ProductModel> create(ProductModel product) async {
    final json = await _apiClient.post(
      ApiConstants.products,
      body: {
        'productName': product.productName,
        'productDescription': product.productDescription,
        'brand': product.brand,
        'unitName': product.unitName,
        'categoryName': product.categoryName,
        'supplierName': product.supplierName,
      },
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return ProductModel.fromJson(json);
  }

  Future<ProductModel> update(int productId, ProductModel product) async {
    final json = await _apiClient.put(
      '${ApiConstants.products}/$productId',
      body: {
        'productId': productId,
        'productName': product.productName,
        'productDescription': product.productDescription,
        'brand': product.brand,
        'unitName': product.unitName,
        'categoryName': product.categoryName,
        'supplierName': product.supplierName,
        'productStatus': product.productStatus,
      },
    );
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return ProductModel.fromJson(json);
  }

  Future<String> delete(int productId, bool productStatus) async {
    final json = await _apiClient.delete(
      '${ApiConstants.products}/DeleteProduct/$productId',
      body: {'productStatus': productStatus},
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return (json['message'] ?? 'Producto eliminado exitosamente').toString();
  }

  Future<List<String>> getAllCatalog(String endpoint, String nameField) async {
    final data = await _apiClient.get(endpoint);
    if (data == null) return [];

    List<dynamic> list = [];
    if (data is List) {
      list = data;
    } else if (data is Map<String, dynamic>) {
      final items = data['items'] ?? data['data'] ?? data['result'];
      if (items is List) {
        list = items;
      } else {
        throw ParsingException();
      }
    } else {
      throw ParsingException();
    }

    return list
        .map(
          (e) => e is Map<String, dynamic>
              ? (e[nameField] ?? e['name'] ?? e['nombre'] ?? '').toString()
              : e.toString(),
        )
        .where((name) => name.trim().isNotEmpty)
        .toList();
  }

  Future<ProductModel> createProduct(ProductModel product) => create(product);
  Future<ProductModel> updateProduct(int id, ProductModel product) =>
      update(id, product);
  Future<String> deleteProduct(int id, bool status) => delete(id, status);
  Future<List<String>> getCatalog(String endpoint, String nameField) =>
      getAllCatalog(endpoint, nameField);
}
