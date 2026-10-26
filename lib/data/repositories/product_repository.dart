import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/presentation/screens/products/models/productmodel.dart';
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
    if (data is! List) throw ParsingException();

    return data
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
