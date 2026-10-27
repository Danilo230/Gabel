import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/presentation/screens/services/models/servicemodels.dart';

class ServiceRepository {
  final ApiClient _apiClient;

  ServiceRepository(this._apiClient);
  Future<ServiceModels> getById(int serviceId) async {
    final json = await _apiClient.get('${ApiConstants.services}/$serviceId');

    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return ServiceModels.fromJson(json);
  }

  Future<List<ServiceModels>> getAll(Map<String, String>? params) async {
    final data = await _apiClient.get(ApiConstants.services, query: params);
    if (data is! List) throw ParsingException();

    return data
        .map((json) => ServiceModels.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<ServiceModels> create(Map<String, dynamic> serviceData) async {
    final json = await _apiClient.post(
      ApiConstants.services,
      body: serviceData,
    );

    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return ServiceModels.fromJson(json);
  }

  Future<ServiceModels> update(
    int serviceId,
    Map<String, dynamic> serviceData,
  ) async {
    final json = await _apiClient.put(
      '${ApiConstants.services}/$serviceId',
      body: serviceData,
    );

    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return ServiceModels.fromJson(json);
  }

  Future<void> delete(int serviceId) async {
    await _apiClient.delete('${ApiConstants.services}/$serviceId');
  }
}
