import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/paged_result_model.dart';
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

  Future<PagedResultModel<ServiceModels>> getAll(
    Map<String, String>? params,
  ) async {
    final data = await _apiClient.get(ApiConstants.services, query: params);
    if (data is! Map<String, dynamic>) throw ParsingException();

    return PagedResultModel.fromJson(data, ServiceModels.fromJson);
  }

  Future<ServiceModels> create(ServiceModels service) async {
    final json = await _apiClient.post(
      ApiConstants.services,
      body: {
        'serviceName': service.serviceName,
        'servicePrice': service.servicePrice,
        'stylistName': service.stylistName,
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
        'stylistName': service.stylistName,
        'serviceDescription': service.serviceDescription,
        'serviceStatus': service.serviceStatus,
      },
    );
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return ServiceModels.fromJson(json);
  }

  Future<ServiceModels> updateService(int serviceId, ServiceModels service) =>
      update(serviceId, service);

  Future<String> delete(int serviceId, bool serviceStatus) async {
    final json = await _apiClient.delete(
      '${ApiConstants.services}/DeleteService/$serviceId',
      body: {'serviceStatus': serviceStatus},
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return json['message'] as String;
  }

  Future<List<String>> getAllCatalog(String endpoint, String keyName) async {
    final data = await _apiClient.get(endpoint);
    if (data is List) {
      return data
          .map((item) {
            if (item is Map<String, dynamic>) {
              return item[keyName]?.toString() ?? '';
            }
            return item.toString();
          })
          .where((name) => name.isNotEmpty)
          .toSet()
          .toList();
    }
    if (data is Map<String, dynamic> && data['items'] is List) {
      final items = data['items'] as List;
      return items
          .map((item) {
            if (item is Map<String, dynamic>) {
              return item[keyName]?.toString() ?? '';
            }
            return item.toString();
          })
          .where((name) => name.isNotEmpty)
          .toSet()
          .toList();
    }
    return <String>[];
  }
}
