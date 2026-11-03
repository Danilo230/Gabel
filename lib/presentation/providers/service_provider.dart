import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/service_models.dart';
import 'package:gabel/services/services_service.dart';

enum ViewStatusService { initial, loading, success, error }

class ServicesProvider extends ChangeNotifier {
  static const int _pageSize = 10;

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

  int _totalPage = 1;
  int get totalPage => _totalPage;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  String _query = '';
  bool get isSearching => _query.isNotEmpty;

  bool? _selectedStatus;
  bool? get selectedStatus => _selectedStatus;

  String? _selectedStylistFilter;
  String? get selectedStylistFilter => _selectedStylistFilter;

  List<ServiceModels> _allServices = [];
  bool _hasAllServices = false;
  Future<void>? _allServicesRequest;

  bool _isSearchLoading = false;
  bool get isSearchLoading => _isSearchLoading;

  String? _searchErrorMessage;
  String? get searchErrorMessage => _searchErrorMessage;

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

  List<StylistItem> stylists = [];
  bool _stylistsLoaded = false;

  String? _stylistError;
  String? get stylistError => _stylistError;

  List<String> get availableStylists => stylists.map((e) => e.name).toList();

  int stylistIdByName(String name) {
    final target = name.trim().toLowerCase();
    for (final item in stylists) {
      if (item.name.trim().toLowerCase() == target) return item.id;
    }
    return 0;
  }

  Future<void> loadStylistsCatalog() async {
    if (_stylistsLoaded) return;
    try {
      stylists = await _service.getAllStylists();
      _stylistsLoaded = stylists.isNotEmpty;
      _stylistError = _stylistsLoaded
          ? null
          : 'No se encontraron estilistas registrados.';
    } catch (e) {
      debugPrint('Error al cargar los estilistas: $e');
      _stylistError = e is AppException
          ? e.message
          : 'No se pudieron cargar los estilistas.';
    }
    notifyListeners();
  }

  Future<void> fetchServices({int pageNumber = 1}) async {
    if (_viewStatus == ViewStatusService.loading) return;
    _viewStatus = ViewStatusService.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _service.getAll(
        pageNumber: pageNumber,
        pageSize: _pageSize,
      );
      _services = result.items;
      _currentPage = result.pageNumber;
      _totalPage = result.totalPages;
      _viewStatus = ViewStatusService.success;
      loadStylistsCatalog();
    } catch (e) {
      _errorMessage = _messageFrom(e);
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
        final result = await _service.getAll(
          pageNumber: page,
          pageSize: _pageSize,
        );
        all.addAll(result.items);
        totalPages = result.totalPages;
        page++;
      } while (page <= totalPages);

      _allServices = all;
      _hasAllServices = true;
    } catch (e) {
      _searchErrorMessage = _messageFrom(e);
    }
    _allServicesRequest = null;
    _isSearchLoading = false;
    notifyListeners();
  }

  Future<ServiceModels?> register(ServiceModels service) {
    return _save(() async {
      final created = await _service.create(service);
      _currentPage = 1;
      await refresh();
      return created;
    });
  }

  Future<ServiceModels?> update(int serviceId, ServiceModels service) {
    return _save(() async {
      final updated = await _service.update(serviceId, service);
      await refresh();
      return updated;
    });
  }

  Future<String?> delete(int serviceId) {
    return _save(() async {
      final message = await _service.delete(serviceId, false);
      await refresh();
      return message;
    });
  }

  Future<T?> _save<T>(Future<T> Function() action) async {
    if (_isSaving) return null;
    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      return await action();
    } catch (e) {
      _errorMessage = _messageFrom(e);
      return null;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  String _messageFrom(Object e) {
    if (e is AppException) return e.message;
    if (e is FormatException) return e.message;
    debugPrint('Error inesperado: $e');
    return 'Ocurrio un error inesperado: Intentalo de nuevo';
  }
}

typedef ServiceProvider = ServicesProvider;
