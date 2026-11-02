import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/customer_model.dart';
import 'package:gabel/services/customer_service.dart';

enum ViewStatusCustomer { initial, loading, success, error }

class CustomerProvider extends ChangeNotifier {
  static const int _pageSize = 10;
  static const int _searchPageSize = 10;

  final CustomerService _customerService;
  CustomerProvider(this._customerService);

  List<CustomerModel> _customers = [];
  List<CustomerModel> get customers => _customers;

  ViewStatusCustomer _viewStatus = ViewStatusCustomer.initial;
  ViewStatusCustomer get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPage = 1;
  int get totalPage => _totalPage;

  String _query = '';
  bool get isSearching => _query.isNotEmpty;

  bool? _selectedStatus;
  bool? get selectedStatus => _selectedStatus;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  List<CustomerModel> _allCustomers = [];
  bool _hasAllCustomers = false;
  Future<void>? _allCustomersRequest;

  bool _isSearchLoading = false;
  bool get isSearchLoading => _isSearchLoading;

  String? _searchErrorMessage;
  String? get searchErrorMessage => _searchErrorMessage;

  List<CustomerModel> get filteredCustomers {
    if (_query.isNotEmpty) {
      return _allCustomers.where((customer) {
        return customer.customerName.toLowerCase().contains(_query);
      }).toList();
    }
    if (_selectedStatus != null) {
      return _allCustomers.where((customer) {
        return customer.customerStatus == _selectedStatus;
      }).toList();
    }
    return _customers;
  }

  String? _customerErrorMessage;
  String? get customerErrorMessage => _customerErrorMessage;

  Future<void> fetchCustomers({int pageNumber = 1}) async {
    if (_viewStatus == ViewStatusCustomer.loading) return;
    _viewStatus = ViewStatusCustomer.loading;
    _errorMessage = null;

    notifyListeners();
    try {
      final result = await _customerService.getAll(
        pageNumber: pageNumber,
        pageSize: _pageSize,
      );
      _customers = result.items;
      _currentPage = result.pageNumber;
      _totalPage = result.totalPages;
      _viewStatus = ViewStatusCustomer.success;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusCustomer.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusCustomer.error;
    } catch (e, stack) {
      debugPrint('Error al obtener los clientes: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
      _viewStatus = ViewStatusCustomer.error;
    }
    notifyListeners();
  }

  Future<void> refresh() async {
    _hasAllCustomers = false;
    await fetchCustomers(pageNumber: _currentPage);
    if (_query.isNotEmpty || _selectedStatus != null) {
      await _loadAllItems();
    }
  }

  Future<void> search(String query) async {
    _query = query.trim().toLowerCase();

    _selectedStatus = null;
    notifyListeners();
    if (_query.isNotEmpty) await _loadAllItems();
  }

  Future<void> setStatusFilter(bool? status) async {
    _selectedStatus = status;
    _query = '';
    notifyListeners();
    if (_selectedStatus != null) await _loadAllItems();
  }

  Future<void> retrySearch() {
    _hasAllCustomers = false;
    _allCustomersRequest = null;
    return _loadAllItems();
  }

  Future<void> _loadAllItems() {
    if (_hasAllCustomers) return Future.value();
    return _allCustomersRequest ??= _fetchAllItems();
  }

  Future<void> _fetchAllItems() async {
    _isSearchLoading = true;
    _searchErrorMessage = null;
    notifyListeners();

    try {
      final List<CustomerModel> all = [];
      int page = 1;
      int totalPages = 1;
      do {
        final result = await _customerService.getAll(
          pageNumber: page,
          pageSize: _searchPageSize,
        );
        all.addAll(result.items);
        totalPages = result.totalPages;
        page++;
      } while (page <= totalPages);
      _allCustomers = all;
      _hasAllCustomers = true;
    } catch (e, stack) {
      debugPrint('Error al cargar todos los clientes: $e');
      debugPrint('$stack');
      _searchErrorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
    }
    _allCustomersRequest = null;
    _isSearchLoading = false;
    notifyListeners();
  }

  Future<CustomerModel?> register(CustomerModel customer) async {
    if (_isSaving) return null;

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    CustomerModel? result;
    try {
      result = await _customerService.create(customer);
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('Error al registrar al cliente: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
      _viewStatus = ViewStatusCustomer.error;
    }

    _isSaving = false;
    notifyListeners();
    return result;
  }

  Future<CustomerModel?> update(int customerId, CustomerModel customer) async {
    if (_isSaving) return null;

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    CustomerModel? result;
    try {
      result = await _customerService.update(customerId, customer);
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('Error al actualizar al cliente: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
    }

    _isSaving = false;
    notifyListeners();
    return result;
  }

  Future<String?> delete(int customerId) async {
    if (_isSaving) return null;
    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    String? message;
    try {
      message = await _customerService.delete(customerId, false);
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('Error al eliminar al cliente: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
    }
    _isSaving = false;
    notifyListeners();
    return message;
  }
}
