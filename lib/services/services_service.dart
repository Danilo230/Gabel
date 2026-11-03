import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/service_models.dart';
import 'package:gabel/data/repositories/service_repository.dart';

class ServicesService {
  final ServiceRepository _serviceRepository;

  ServicesService(this._serviceRepository);

  Future<ServiceModels> getById(int serviceId) async {
    if (serviceId <= 0) {
      throw const FormatException('El ID del servicio no es válido.');
    }
    return await _serviceRepository.getById(serviceId);
  }

  Future<PagedResultModel<ServiceModels>> getAll({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos.',
      );
    }

    return await _serviceRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  Future<ServiceModels> create(ServiceModels service) async {
    final name = service.serviceName.trim();
    final description = service.serviceDescription.trim();
    final stylist = service.stylistName.trim();
    final price = service.servicePrice;

    if (name.isEmpty || stylist.isEmpty) {
      throw Exception('El nombre y el estilista son obligatorios.');
    }

    if (price <= 0) {
      throw const FormatException('El precio del servicio debe ser mayor a 0.');
    }

    return await _serviceRepository.create(
      ServiceModels(
        serviceId: service.serviceId,
        serviceName: name,
        serviceDescription: description,
        servicePrice: price,
        stylistName: stylist,
        serviceStatus: true,
      ),
    );
  }

  Future<ServiceModels> update(int serviceId, ServiceModels service) async {
    if (serviceId <= 0) {
      throw const FormatException(
        'El ID del servicio no es válido para actualizar.',
      );
    }

    final name = service.serviceName.trim();
    final description = service.serviceDescription.trim();
    final stylist = service.stylistName.trim();
    final price = service.servicePrice;

    if (name.isEmpty || stylist.isEmpty) {
      throw Exception('El nombre y el estilista son obligatorios.');
    }

    if (price <= 0) {
      throw const FormatException('El precio del servicio debe ser mayor a 0.');
    }

    return await _serviceRepository.update(
      serviceId,
      ServiceModels(
        serviceId: serviceId,
        serviceName: name,
        serviceDescription: description,
        servicePrice: price,
        stylistName: stylist,
        serviceStatus: service.serviceStatus,
      ),
    );
  }

  Future<String> delete(int serviceId, [bool serviceStatus = false]) async {
    if (serviceId <= 0) {
      throw const FormatException('El ID del servicio no es válido.');
    }
    return await _serviceRepository.delete(serviceId, serviceStatus);
  }

  Future<List<String>> getAllStylists() async {
    try {
      final users = await _serviceRepository.getAllCatalog(
        ApiConstants.users,
        'userName',
      );
      if (users.isNotEmpty) return users;
    } catch (_) {}
    return <String>[];
  }

  Future<ServiceModels> createService(ServiceModels service) => create(service);
  Future<ServiceModels> updateService(int serviceId, ServiceModels service) =>
      update(serviceId, service);
  Future<String> deleteService(int serviceId, bool serviceStatus) =>
      delete(serviceId, serviceStatus);
}

typedef ServiceService = ServicesService;
