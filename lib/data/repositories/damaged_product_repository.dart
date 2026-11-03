import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/damaged_product_model.dart';

class DamagedProductRepository {
  final ApiClient _apiClient;

  DamagedProductRepository(this._apiClient);

  Future<List<DamagedProductModel>> getAll() async {
    final data = await _apiClient.get(ApiConstants.damagedProducts);
    if (data is! List) throw ParsingException();

    return data
        .map((json) => DamagedProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<DamagedProductModel> create(CreateDamagedProductModel damagedProduct) async {
    final json = await _apiClient.post(
      ApiConstants.damagedProducts,
      body: damagedProduct.toJson(),
    );
    if (json is! Map<String, dynamic>) throw ParsingException();

    return DamagedProductModel.fromJson(json);
  }
}
