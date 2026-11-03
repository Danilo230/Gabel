import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/paged_result_model.dart';
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

  Future<PagedResultModel<ProductModel>> getAll(
    Map<String, String>? params,
  ) async {
    final data = await _apiClient.get(ApiConstants.products, query: params);
    if (data is! Map<String, dynamic>) throw ParsingException();

    return PagedResultModel.fromJson(data, ProductModel.fromJson);
  }

  Future<ProductModel> create(ProductModel product) async {
    final json = await _apiClient.post(
      ApiConstants.products,
      body: {
        'productName': product.productName,
        'productDescription': product.productDescription,
        'brand': product.brand,
        'productStatus': true,
        'unitId': product.unitId,
        'unitName': product.unitName,
        'categoryId': product.categoryId,
        'categoryName': product.categoryName,
        'supplierId': product.supplierId,
        'supplierName': product.supplierName,
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
        'productId': productId,
        'productName': product.productName,
        'productDescription': product.productDescription,
        'brand': product.brand,
        'productStatus': product.productStatus,
        'unitId': product.unitId,
        'unitName': product.unitName,
        'categoryId': product.categoryId,
        'categoryName': product.categoryName,
        'supplierId': product.supplierId,
        'supplierName': product.supplierName,
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
    return json['message'] as String;
  }

  Future<List<CatalogItem>> getAllCatalog(
    String endpoint, {
    required String idKey,
    required String nameKey,
  }) async {
    final data = await _apiClient.get(endpoint);
    final list = data is Map<String, dynamic> ? data['items'] : data;
    if (list is! List) throw ParsingException();

    return list
        .map((e) {
          final map = e as Map<String, dynamic>;
          return CatalogItem(
            id: map[idKey] as int? ?? 0,
            name: map[nameKey] as String? ?? '',
          );
        })
        .where((item) => item.name.isNotEmpty)
        .toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }
}
