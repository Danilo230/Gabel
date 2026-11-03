import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/stylist_model.dart';

class StylistRepository {
  final ApiClient _apiClient;

  StylistRepository(this._apiClient);

  Future<PagedResultModel<StylistModel>> getAll(
    Map<String, String>? params,
  ) async {
    final data = await _apiClient.get(ApiConstants.stylists, query: params);
    if (data is! Map<String, dynamic>) throw ParsingException();

    return PagedResultModel.fromJson(data, StylistModel.fromJson);
  }

  Future<StylistModel> getById(int stylistId) async {
    final json = await _apiClient.get('${ApiConstants.stylists}/$stylistId');
    if (json is! Map<String, dynamic>) throw ParsingException();

    return StylistModel.fromJson(json);
  }

  Future<StylistModel> getByName(String name) async {
    final json = await _apiClient.get(
      '${ApiConstants.stylists}/byname/${Uri.encodeComponent(name)}',
    );
    if (json is! Map<String, dynamic>) throw ParsingException();

    return StylistModel.fromJson(json);
  }
}
