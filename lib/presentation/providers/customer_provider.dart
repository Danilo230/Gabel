import 'package:flutter/material.dart';
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

  final CustomerService _customerService;
  CustomerProvider(this._customerService);

  Future<void> fetchCustomers() async {
    _viewStatus = ViewStatusCustomer.loading;
    notifyListeners();
  }
}
