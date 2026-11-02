
import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/supplier_model.dart';

class SupplierRepository {
  final ApiClient _apiClient;

  SupplierRepository(this._apiClient);

  Future<List<SupplierModel>> getAll({
    Map<String, String>? params,
  }) async {
    final json = await _apiClient.get(
      ApiConstants.suppliers,
      query: params,
    );

    if (json is! Map<String, dynamic>) {
      throw const ParsingException();
    }

    return PagedResultModel.fromJson(
      json,
      SupplierModel.fromJson,
    ).items;
  }
}
