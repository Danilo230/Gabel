import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/purchase_model.dart';
import 'package:gabel/data/models/purchase_with_details_model.dart';

class PurchaseRepository {
  final ApiClient _apiClient;

  PurchaseRepository(this._apiClient);

  Future<PagedResultModel<PurchaseModel>> getAll(Map<String, String> map, {Map<String, String>? params,}) async {
    final data = await _apiClient.get(
      '${ApiConstants.purchasesHistory}/master',
      query: params,
    );
    if (data is! Map<String, dynamic>) throw const ParsingException();

    return PagedResultModel.fromJson(data, PurchaseModel.fromJson);
  }

  Future<PurchaseWithDetailsModel> getById(int purchaseId) async {
    final json = await _apiClient.get('${ApiConstants.purchasesHistory}/$purchaseId/details');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw const ParsingException();

    return PurchaseWithDetailsModel.fromJson(json);
  }

  Future<PagedResultModel<PurchaseModel>> getByProduct(int productId, {Map<String, String>? params,}) async {
    final json = await _apiClient.get(
      '${ApiConstants.purchasesHistory}/byproduct/$productId',
      query: params,
    );
    if (json is! Map<String, dynamic>) throw const ParsingException();

    return PagedResultModel.fromJson(json, PurchaseModel.fromJson);
  }

  Future<PagedResultModel<PurchaseModel>> getBySupplier(int supplierId, {Map<String, String>? params,}) async {
    final json = await _apiClient.get(
      '${ApiConstants.purchasesHistory}/bysupplier/$supplierId',
      query: params,
    );
    if (json is! Map<String, dynamic>) throw const ParsingException();

    return PagedResultModel.fromJson(json, PurchaseModel.fromJson);
  }
  Future<PagedResultModel<PurchaseModel>> getByDateRange({required DateTime startDate, required DateTime endDate,
  Map<String, String>? params,}) async {

    final json = await _apiClient.get(
      '${ApiConstants.purchasesHistory}/HistorialPorFecha',
      query: {
        ...?params,
        'startDate': _formatDate(startDate),
        'endDate': _formatDate(endDate),
      },
    );
    if (json is! Map<String, dynamic>) throw const ParsingException();

    return PagedResultModel.fromJson(json, PurchaseModel.fromJson);
  }

  String _formatDate(DateTime d) =>
  '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

}
