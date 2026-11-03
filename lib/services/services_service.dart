import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/service_models.dart';
import 'package:gabel/data/repositories/service_repository.dart';

class ServicesService {
  final ServiceRepository _serviceRepository;

  ServicesService(this._serviceRepository);

  Future<ServiceModels> getById(int serviceId) async {
    return await _serviceRepository.getById(serviceId);
  }

  Future<PagedResultModel<ServiceModels>> getAll({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }
    return await _serviceRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  ServiceModels _clean(int serviceId, ServiceModels service, bool status) {
    final name = service.serviceName.trim();
    final stylist = service.stylistName.trim();

    if (name.isEmpty || stylist.isEmpty) {
      throw const FormatException('Todos los campos son obligatorios.');
    }
    if (service.servicePrice <= 0) {
      throw const FormatException('Ingresa un precio válido mayor a 0.');
    }

    return ServiceModels(
      serviceId: serviceId,
      serviceName: name,
      servicePrice: service.servicePrice,
      serviceStatus: status,
      serviceDescription: service.serviceDescription.trim(),
      stylistId: service.stylistId,
      stylistName: stylist,
    );
  }

  Future<ServiceModels> create(ServiceModels service) async {
    return await _serviceRepository.create(
      _clean(service.serviceId, service, true),
    );
  }

  Future<ServiceModels> update(int serviceId, ServiceModels service) async {
    return await _serviceRepository.update(
      serviceId,
      _clean(serviceId, service, service.serviceStatus),
    );
  }

  Future<String> delete(int serviceId, bool serviceStatus) async {
    if (serviceId <= 0) {
      throw const FormatException('Id de servicio no es válido');
    }
    return await _serviceRepository.delete(serviceId, serviceStatus);
  }

  Future<List<StylistItem>> getAllStylists() =>
      _serviceRepository.getAllStylists();
}
