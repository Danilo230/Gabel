
import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/service_models.dart';
import 'package:gabel/presentation/providers/user_provider.dart'
    show ViewStatus;
import 'package:gabel/services/services_service.dart';

class ServicesProvider extends ChangeNotifier {
  static const int _pageSize = 10;

  final ServicesService _servicesService;
  ServicesProvider(this._servicesService);

  List<ServiceModels> _items = [];
  List<ServiceModels> get items => _items;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPages = 1;
  int get totalPages => _totalPages;

  final Map<int, ServiceModels> _serviceCache = {};

  String? _serviceErrorMessage;
  String? get serviceErrorMessage => _serviceErrorMessage;

  Future<void> fetchServices({
    int pageNumber = 1,
    int pageSize = _pageSize,
  }) async {
    if (_viewStatus == ViewStatus.loading) return;

    _viewStatus = ViewStatus.loading;
    _errorMessage = null;
    _serviceCache.clear();
    notifyListeners();

    try {
      final result = await _servicesService.getAll(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

      _items = result;
      _currentPage = pageNumber;
      _totalPages = 1;

      _viewStatus = ViewStatus.success;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH SERVICES: $e');
      debugPrint('$stack');
      _errorMessage =
          'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _viewStatus = ViewStatus.error;
    }

    notifyListeners();
  }

  Future<void> refresh() => fetchServices(pageNumber: _currentPage);

  Future<ServiceModels?> fetchService(int serviceId) async {
    final cached = _serviceCache[serviceId];
    if (cached != null) return cached;

    _serviceErrorMessage = null;

    try {
      final service = await _servicesService.getById(serviceId);
      _serviceCache[serviceId] = service;
      return service;
    } on AppException catch (e) {
      _serviceErrorMessage = e.message;
    } on FormatException catch (e) {
      _serviceErrorMessage = e.message;
    } catch (e, stack) {
      debugPrint('ERROR FETCH SERVICE: $e');
      debugPrint('$stack');
      _serviceErrorMessage =
          'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
    }

    return null;
  }

  Future<bool> createService(ServiceModels service) async {
    _viewStatus = ViewStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final newService = await _servicesService.createService(service);
      _items.insert(0, newService);
      if (newService.serviceId != null) {
        _serviceCache[newService.serviceId!] = newService;
      }
      _viewStatus = ViewStatus.success;
      notifyListeners();
      return true;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } catch (e, stack) {
      debugPrint('ERROR CREATE SERVICE: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error al crear el servicio.';
      _viewStatus = ViewStatus.error;
    }

    notifyListeners();
    return false;
  }

  Future<bool> updateService(int serviceId, ServiceModels service) async {
    _viewStatus = ViewStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final updated = await _servicesService.updateService(serviceId, service);
      final index = _items.indexWhere((s) => s.serviceId == serviceId);
      if (index != -1) {
        _items[index] = updated;
      }
      _serviceCache[serviceId] = updated;
      _viewStatus = ViewStatus.success;
      notifyListeners();
      return true;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } catch (e, stack) {
      debugPrint('ERROR UPDATE SERVICE: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error al actualizar el servicio.';
      _viewStatus = ViewStatus.error;
    }

    notifyListeners();
    return false;
  }

  Future<bool> deleteService(int serviceId, bool serviceStatus) async {
    try {
      await _servicesService.deleteService(serviceId, serviceStatus);
      _items.removeWhere((s) => s.serviceId == serviceId);
      _serviceCache.remove(serviceId);
      notifyListeners();
      return true;
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('ERROR DELETE SERVICE: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error al eliminar el servicio.';
    }

    notifyListeners();
    return false;
  }
}
