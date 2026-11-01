import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/sale_model.dart';
import 'package:gabel/data/models/sale_whit_details_model.dart';

class SaleRepository {
  final ApiClient _apiClient;

  SaleRepository(this._apiClient);

  Future<PagedResultModel<SaleModel>> getAll({Map<String, String>? params,}) async {
    final data = await _apiClient.get(ApiConstants.salesHistory, query: params);
    if (data is! Map<String, dynamic>) throw const ParsingException();

    return PagedResultModel.fromJson(data, SaleModel.fromJson);
  }
  
  Future<SaleWithDetailsModel> getById(int saleId) async {
    final json = await _apiClient.get('${ApiConstants.salesHistory}/$saleId/details');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw const ParsingException();

    return SaleWithDetailsModel.fromJson(json);
  }

  Future<PagedResultModel<SaleModel>> getByProduct(int productId, {Map<String, String>? params,}) async {
    final json = await _apiClient.get(
      '${ApiConstants.salesHistory}/byproduct/$productId',
      query: params,
    );
    if (json is! Map<String, dynamic>) throw const ParsingException();

    return PagedResultModel.fromJson(json, SaleModel.fromJson);
  }

  Future<PagedResultModel<SaleModel>> getByService(int serviceId, {Map<String, String>? params,}) async {
    final json = await _apiClient.get(
      '${ApiConstants.salesHistory}/byservice/$serviceId',
      query: params,
    );
    if (json is! Map<String, dynamic>) throw const ParsingException();

    return PagedResultModel.fromJson(json, SaleModel.fromJson);
  }

  Future<PagedResultModel<SaleModel>> getByDateRange({required DateTime startDate,required DateTime endDate,
  Map<String, String>? params,
  }) async {
    final json = await _apiClient.get(
      '${ApiConstants.salesHistory}/historialPorFecha',
      query: {
        ...?params,
        'startDate': _formatDate(startDate),
        'endDate': _formatDate(endDate),
      },
    );
    if (json is! Map<String, dynamic>) throw const ParsingException();

    return PagedResultModel.fromJson(json, SaleModel.fromJson);
  }

  String _formatDate(DateTime d) =>
  '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

}