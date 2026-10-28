import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/inventory_model.dart';
import 'package:gabel/data/models/paged_result_model.dart';

class InventoryRepository {
  final ApiClient _apiClient;

  InventoryRepository(this._apiClient);

  Future<PagedResultModel<InventoryModel>> getAll(
    Map<String, String>? params,
  ) async {
    final data = await _apiClient.get(ApiConstants.inventory, query: params);
    if (data is! Map<String, dynamic>) throw ParsingException();

    return PagedResultModel.fromJson(data, InventoryModel.fromJson);
  }
}
