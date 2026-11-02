import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/constants/api_constants.dart';

class ProductRepository {
  final ApiClient _apiClient;

  ProductRepository(this._apiClient);

  Future<ProductModel> getById(int productId) async {
    final json = await _apiClient.get('${ApiConstants.products}/$productId');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return ProductModel.fromJson(json);
  }

  Future<List<ProductModel>> getAll(Map<String, String>? params) async {
    final data = await _apiClient.get(ApiConstants.products, query: params);
    if (data is! Map<String, dynamic>) throw ParsingException();

    final items = data['items'];
    if (items is! List) throw ParsingException();

    return items
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    final json = await _apiClient.post(
      ApiConstants.products,
      body: {
        'productName': product.productName,
        'productDescription': product.productDescription,
        'productBrand': product.brand,
        'productUnit': product.unitName,
        'productCategory': product.categoryName,
        'productSupplier': product.supplierName,
      },
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return ProductModel.fromJson(json);
  }

  Future<ProductModel> updateProduct(
    int productId,
    ProductModel product,
  ) async {
    final json = await _apiClient.put(
      '${ApiConstants.products}/$productId',
      body: {
        'productName': product.productName,
        'productDescription': product.productDescription,
        'productBrand': product.brand,
        'productUnit': product.unitName,
        'productCategory': product.categoryName,
        'productSupplier': product.supplierName,
        'productStatus': product.productStatus,
      },
    );
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return ProductModel.fromJson(json);
  }

  Future<String> deleteProduct(int productId, bool productStatus) async {
    final json = await _apiClient.delete(
      '${ApiConstants.products}/DeleteProduct/$productId',
      body: {'productStatus': productStatus},
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return json['message'] as String;
  }

  // para obtener las listas en inputs de seleccion
  Future<List<String>> getCatalog(String endpoint, String nameField) async {
    final data = await _apiClient.get(endpoint);
    final list = data is Map<String, dynamic> ? data['items'] : data;
    if (list is! List) throw ParsingException();

    return list
        .map(
          (e) => e is Map<String, dynamic>
              ? (e[nameField] ?? '').toString()
              : e.toString(),
        )
        .where((name) => name.trim().isNotEmpty)
        .toList();
  }
}
