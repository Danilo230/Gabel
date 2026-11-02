import 'package:gabel/data/models/service_models.dart';
import 'package:gabel/data/repositories/service_repository.dart';

class ServicesService {
  final ServiceRepository _serviceRepository;

  ServicesService(this._serviceRepository);

  Future<ServiceModels> getById(int serviceId) async {
    return await _serviceRepository.getById(serviceId);
  }

  Future<List<ServiceModels>> getAll({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    return await _serviceRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  Future<ServiceModels> createService(ServiceModels service) async {
    final name = service.serviceName.trim();
    final price = service.servicePrice.toStringAsFixed(2);
    final stilist = service.stylistName.trim();
    final description = service.serviceDescription.trim();

    if (name.isEmpty || price.isEmpty || stilist.isEmpty) {
      throw Exception('Los parámetros no pueden estar vacios');
    }

    return await _serviceRepository.create(
      ServiceModels(
        serviceId: service.serviceId,
        serviceName: name,
        servicePrice: service.servicePrice,
        stylistName: stilist,
        serviceDescription: description,
        serviceStatus: true,
      ),
    );
  }

  Future<ServiceModels> updateService(
    int serviceId,
    ServiceModels service,
  ) async {
    final name = service.serviceName.trim();
    final price = service.servicePrice.toStringAsFixed(2);
    final stilist = service.stylistName.trim();
    final description = service.serviceDescription.trim();

    if (name.isEmpty || price.isEmpty || stilist.isEmpty) {
      throw Exception('Los parámetros no pueden estar vacios');
    }

    return await _serviceRepository.update(
      serviceId,
      ServiceModels(
        serviceId: serviceId,
        serviceName: name,
        servicePrice: service.servicePrice,
        stylistName: stilist,
        serviceDescription: description,
        serviceStatus: service.serviceStatus,
      ),
    );
  }

  Future<String> deleteService(int serviceId, bool serviceStatus) async {
    if (serviceId <= 0) {
      throw Exception('Id de servicio no es válido');
    }
    return await _serviceRepository.delete(serviceId, serviceStatus);
  }
}
