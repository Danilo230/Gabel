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
        'serviceDescription': service.serviceDescription,
        'serviceStatus': true,
        'stylistId': service.stylistId,
        'stylistName': service.stylistName,
      },
    );
    if (json is! Map<String, dynamic>) throw ParsingException();
    return ServiceModels.fromJson(json);
  }

  Future<ServiceModels> update(int serviceId, ServiceModels service) async {
    final json = await _apiClient.put(
      '${ApiConstants.services}/$serviceId',
      body: {
        'serviceId': serviceId,
        'serviceName': service.serviceName,
        'servicePrice': service.servicePrice,
        'serviceDescription': service.serviceDescription,
        'serviceStatus': service.serviceStatus,
        'stylistId': service.stylistId,
        'stylistName': service.stylistName,
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

  Future<List<StylistItem>> getAllStylists() async {
    final data = await _apiClient.get(ApiConstants.stylists);
    final list = data is Map<String, dynamic> ? data['items'] : data;
    if (list is! List) throw ParsingException();

    return list
        .map((e) {
          final map = e as Map<String, dynamic>;
          return StylistItem(
            id: map['stylistId'] as int? ?? 0,
            name: map['stylistName'] as String? ?? '',
          );
        })
        .where((item) => item.name.isNotEmpty)
        .toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }
}
