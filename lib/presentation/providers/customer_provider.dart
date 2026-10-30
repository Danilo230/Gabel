import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/customer_model.dart';
import 'package:gabel/services/customer_service.dart';

enum ViewStatusCustomer { initial, loading, success, error }

class CustomerProvider extends ChangeNotifier {
  List<CustomerModel> _customers = [];
  List<CustomerModel> get customers => _customers;

  ViewStatusCustomer _viewStatus = ViewStatusCustomer.initial;
  ViewStatusCustomer get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  final CustomerService _customerService;
  CustomerProvider(this._customerService);

  Future<void> fetchCustomers() async {
    _viewStatus = ViewStatusCustomer.loading;
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
    }

    _isSaving = false;
    notifyListeners();
    return result;
  }
}
