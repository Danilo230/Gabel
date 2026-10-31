import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/purchase_model.dart';
import 'package:gabel/data/models/purchase_whit_details_model.dart';

class PurchaseRepository {
  final ApiClient _apiClient;

  PurchaseRepository(this._apiClient);

  Future<PagedResultModel<PurchaseModel>> getAll(
    Map<String, String>? params,
  ) async {
    final data = await _apiClient.get(ApiConstants.purchasesHistory, query: params);
    if (data is! Map<String, dynamic>) throw ParsingException();

    return PagedResultModel.fromJson(data, PurchaseModel.fromJson);
  }

  Future<PurchaseWithDetailsModel> getById(int purchaseId) async {
    final json = await _apiClient.get('${ApiConstants.purchasesHistory}/$purchaseId');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();
    
    return PurchaseWithDetailsModel.fromJson(json);
  }

  Future<PagedResultModel<PurchaseModel>> getByProduct(String productName, {Map<String, String>? params,}) async {
    final json = await _apiClient.get(
      '${ApiConstants.purchasesHistory}/product',
      query: {...?params, 'productName': productName},
    );
    if (json is! Map<String, dynamic>) throw ParsingException();

    return PagedResultModel.fromJson(json, PurchaseModel.fromJson);
  }

  Future<PagedResultModel<PurchaseModel>> getBySupplier(String supplierName, {Map<String, String>? params,}) async {
    final json = await _apiClient.get(
      '${ApiConstants.purchasesHistory}/supplier',
      query: {...?params, 'supplierName': supplierName},
    );
    if (json is! Map<String, dynamic>) throw ParsingException();

    return PagedResultModel.fromJson(json, PurchaseModel.fromJson);
  }

}
