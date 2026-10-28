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

  Future<ProductModel> create(ProductModel product) async {
    final json = await _apiClient.post(
      ApiConstants.products,
      body: {
        'productName': product.productName,
        'productDescription': product.productDescription,
        'productBrand': product.productBrand,
        'productUnit': product.productUnit,
        'productCategory': product.productCategory,
        'productSupplier': product.productSupplier,
        'productPrice': product.productPrice,
      },
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return ProductModel.fromJson(json);
  }

  Future<ProductModel> update(int productId, ProductModel product) async {
    final json = await _apiClient.put(
      '${ApiConstants.products}/$productId',
      body: {
        'productName': product.productName,
        'productDescription': product.productDescription,
        'productBrand': product.productBrand,
        'productUnit': product.productUnit,
        'productCategory': product.productCategory,
        'productSupplier': product.productSupplier,
        'productPrice': product.productPrice,
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
    return json['message'] as String;
  }
}
