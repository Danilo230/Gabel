import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/service_models.dart';
import 'package:gabel/services/services_service.dart';

enum ViewStatusService { initial, loading, success, error }

class ServicesProvider extends ChangeNotifier {
  static const int _pageSize = 10;
  static const int _searchPageSize = 10;

  final ServicesService _service;
  ServicesProvider(this._service);

  List<ServiceModels> _services = [];
  List<ServiceModels> get services => _services;
  List<ServiceModels> get items => filteredServices;

  ViewStatusService _viewStatus = ViewStatusService.initial;
  ViewStatusService get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPage = 7;
  int get totalPage => _totalPage;
  int get totalPages => _totalPage;

  String _query = '';
  bool get isSearching => _query.isNotEmpty;

  bool? _selectedStatus;
  bool? get selectedStatus => _selectedStatus;

  String? _selectedStylistFilter;
  String? get selectedStylistFilter => _selectedStylistFilter;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  List<ServiceModels> _allServices = [];
  bool _hasAllServices = false;
  Future<void>? _allServicesRequest;

  bool _isSearchLoading = false;
  bool get isSearchLoading => _isSearchLoading;

  String? _searchErrorMessage;
  String? get searchErrorMessage => _searchErrorMessage;

  List<String> _stylistsCatalog = [];

  List<ServiceModels> get filteredServices {
    if (_query.isNotEmpty) {
      return _allServices.where((service) {
        return service.serviceName.toLowerCase().contains(_query) ||
            service.stylistName.toLowerCase().contains(_query);
      }).toList();
    }
    if (_selectedStatus != null) {
      return _allServices.where((service) {
        return service.serviceStatus == _selectedStatus;
      }).toList();
    }
    if (_selectedStylistFilter != null && _selectedStylistFilter!.isNotEmpty) {
      return _allServices.where((service) {
        return service.stylistName.trim().toLowerCase() ==
            _selectedStylistFilter!.trim().toLowerCase();
      }).toList();
    }
    return _services;
  }

  List<String> get availableStylists {
    final set = <String>{};
    set.addAll(_stylistsCatalog.where((s) => s.trim().isNotEmpty));
    set.addAll(
      _allServices.map((s) => s.stylistName.trim()).where((s) => s.isNotEmpty),
    );
    set.addAll(
      _services.map((s) => s.stylistName.trim()).where((s) => s.isNotEmpty),
    );
    return set.toList()..sort();
  }

  Future<void> loadStylistsCatalog() async {
    try {
      final list = await _service.getAllStylists();
      if (list.isNotEmpty) {
        _stylistsCatalog = list;
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<void> fetchServices({int pageNumber = 1}) async {
    if (_viewStatus == ViewStatusService.loading) return;
    _viewStatus = ViewStatusService.loading;
    _errorMessage = null;

    notifyListeners();
    try {
      final dynamic result = await _service.getAll(
        pageNumber: pageNumber,
        pageSize: _pageSize,
      );

      if (result is List<ServiceModels>) {
        _services = result;
        _currentPage = pageNumber;
        if (result.length < _pageSize) {
          _totalPage = pageNumber > 1 ? pageNumber : 1;
        } else {
          _totalPage = pageNumber >= 7 ? pageNumber + 1 : 7;
        }
      } else {
        _services = result.items;
        _currentPage = result.pageNumber;
        _totalPage = result.totalPages;
      }

      _viewStatus = ViewStatusService.success;
      loadStylistsCatalog();
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusService.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusService.error;
    } catch (e, stack) {
      debugPrint('Error al obtener los servicios: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
      _viewStatus = ViewStatusService.error;
    }
    notifyListeners();
  }

  Future<void> refresh() async {
    _hasAllServices = false;
    await fetchServices(pageNumber: _currentPage);
    if (_query.isNotEmpty ||
        _selectedStatus != null ||
        _selectedStylistFilter != null) {
      await _loadAllItems();
    }
  }

  Future<void> search(String query) async {
    _query = query.trim().toLowerCase();
    _selectedStatus = null;
    _selectedStylistFilter = null;
    notifyListeners();
    if (_query.isNotEmpty) await _loadAllItems();
  }

  Future<void> setStatusFilter(bool? status) async {
    _selectedStatus = status;
    _selectedStylistFilter = null;
    _query = '';
    notifyListeners();
    if (_selectedStatus != null) await _loadAllItems();
  }

  Future<void> setStylistFilter(String? stylist) async {
    _selectedStylistFilter = stylist;
    _selectedStatus = null;
    _query = '';
    notifyListeners();
    if (_selectedStylistFilter != null && _selectedStylistFilter!.isNotEmpty) {
      await _loadAllItems();
    }
  }

  void clearFilters() {
    _selectedStatus = null;
    _selectedStylistFilter = null;
    _query = '';
    notifyListeners();
  }

  Future<void> ensureAllServicesLoaded() async {
    await _loadAllItems();
    await loadStylistsCatalog();
  }

  Future<void> retrySearch() {
    _hasAllServices = false;
    _allServicesRequest = null;
    return _loadAllItems();
  }

  Future<void> _loadAllItems() {
    if (_hasAllServices) return Future.value();
    return _allServicesRequest ??= _fetchAllItems();
  }

  Future<void> _fetchAllItems() async {
    _isSearchLoading = true;
    _searchErrorMessage = null;
    notifyListeners();

    try {
      final List<ServiceModels> all = [];
      int page = 1;
      int totalPages = 1;
      do {
        final dynamic result = await _service.getAll(
          pageNumber: page,
          pageSize: _searchPageSize,
        );
        if (result is List<ServiceModels>) {
          all.addAll(result);
          if (result.length < _searchPageSize) break;
          totalPages = page + 1;
        } else {
          all.addAll(result.items);
          totalPages = result.totalPages;
        }
        page++;
      } while (page <= totalPages);
      _allServices = all;
      _hasAllServices = true;
    } catch (e, stack) {
      debugPrint('Error al cargar todos los servicios: $e');
      debugPrint('$stack');
      _searchErrorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
    }
    _allServicesRequest = null;
    _isSearchLoading = false;
    notifyListeners();
  }

  Future<ServiceModels?> register(ServiceModels service) async {
    if (_isSaving) return null;

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    ServiceModels? result;
    try {
      result = await _service.create(service);
      await refresh();
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('Error al registrar el servicio: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
      _viewStatus = ViewStatusService.error;
    }

    _isSaving = false;
    notifyListeners();
    return result;
  }

  Future<ServiceModels?> update(int serviceId, ServiceModels service) async {
    if (_isSaving) return null;

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    ServiceModels? result;
    try {
      result = await _service.update(serviceId, service);
      await refresh();
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('Error al actualizar el servicio: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
    }

    _isSaving = false;
    notifyListeners();
    return result;
  }

  Future<String?> delete(int serviceId) async {
    if (_isSaving) return null;
    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    String? message;
    try {
      message = await _service.delete(serviceId, false);
      await refresh();
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('Error al eliminar el servicio: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
    }
    _isSaving = false;
    notifyListeners();
    return message;
  }

  Future<bool> createService(ServiceModels service) async {
    final result = await register(service);
    return result != null;
  }

  Future<bool> updateService(ServiceModels service, [int? id]) async {
    final result = await update(id ?? service.serviceId, service);
    return result != null;
  }

  Future<bool> deleteService(int serviceId) async {
    final result = await delete(serviceId);
    return result != null;
  }
}

typedef ServiceProvider = ServicesProvider;
