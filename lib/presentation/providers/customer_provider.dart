import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/customer_model.dart';
import 'package:gabel/services/customer_service.dart';

enum ViewStatusCustomer { initial, loading, success, error }

class CustomerProvider extends ChangeNotifier {
  static const int _pageSize = 10;

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

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  final CustomerService _customerService;
  CustomerProvider(this._customerService);

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
}
