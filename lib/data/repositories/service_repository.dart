import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/data/models/service_models.dart';

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
    if (data is! Map<String, dynamic>) throw ParsingException();

    final items = data['items'];
    if (items is! List) throw ParsingException();

    return items
        .map((json) => ServiceModels.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<ServiceModels> create(ServiceModels service) async {
    final json = await _apiClient.post(
      ApiConstants.services,
      body: {
        'serviceName': service.serviceName,
        'servicePrice': service.servicePrice,
        'serviceStilist': service.serviceStilist,
        'serviceDescription': service.serviceDescription,
      },
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return ServiceModels.fromJson(json);
  }

  Future<ServiceModels> update(int serviceId, ServiceModels service) async {
    final json = await _apiClient.put(
      '${ApiConstants.services}/$serviceId',
      body: {
        'serviceName': service.serviceName,
        'servicePrice': service.servicePrice,
        'serviceStilist': service.serviceStilist,
        'serviceDescription': service.serviceDescription,
        'serviceStatus': service.serviceStatus,
      },
    );
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return ServiceModels.fromJson(json);
  }

  Future<String> delete(int serviceId, bool serviceStatus) async {
    final json = await _apiClient.delete(
      '${ApiConstants.services}/DeleteService/$serviceId',
      body: {'serviceStatus': serviceStatus},
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return json['message'] as String;
  }
}
