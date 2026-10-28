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

  Future<ServiceModels> create(ServiceModels service) async {
    final name = service.serviceName.trim();
    final price = service.servicePrice.trim();
    final stilist = service.serviceStilist.trim();
    final description = service.serviceDescription.trim();

    if (name.isEmpty || price.isEmpty || stilist.isEmpty) {
      throw Exception('Los parámetros no pueden estar vacios');
    }

    return await _serviceRepository.create(
      ServiceModels(
        serviceId: service.serviceId,
        serviceName: name,
        servicePrice: price,
        serviceStilist: stilist,
        serviceDescription: description,
        serviceStatus: true,
      ),
    );
  }

  Future<ServiceModels> update(int serviceId, ServiceModels service) async {
    final name = service.serviceName.trim();
    final price = service.servicePrice.trim();
    final stilist = service.serviceStilist.trim();
    final description = service.serviceDescription.trim();

    if (name.isEmpty || price.isEmpty || stilist.isEmpty) {
      throw Exception('Los parámetros no pueden estar vacios');
    }

    return await _serviceRepository.create(
      ServiceModels(
        serviceId: serviceId,
        serviceName: name,
        servicePrice: price,
        serviceStilist: stilist,
        serviceDescription: description,
        serviceStatus: service.serviceStatus,
      ),
    );
  }

  Future<String> delete(int serviceId, bool serviceStatus) async {
    if (serviceId <= 0) {
      throw Exception('Id de servicio no es válido');
    }
    return await _serviceRepository.delete(serviceId, serviceStatus);
  }
}
