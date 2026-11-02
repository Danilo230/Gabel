
import 'package:flutter/material.dart';
import 'package:gabel/data/models/supplier_model.dart';
import 'package:gabel/services/supplier_service.dart';

enum ViewStatusSupplier {
  initial,
  loading,
  success,
  error,
}

class SupplierProvider extends ChangeNotifier {
  final SupplierService _supplierService;

  SupplierProvider(this._supplierService);

  List<SupplierModel> _suppliers = [];

  List<SupplierModel> get suppliers => _suppliers;

  ViewStatusSupplier _viewStatus = ViewStatusSupplier.initial;

  ViewStatusSupplier get viewStatus => _viewStatus;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> fetchSuppliers() async {
    if (_viewStatus == ViewStatusSupplier.loading) return;

    _viewStatus = ViewStatusSupplier.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _supplierService.getAll();

      _suppliers = result;

      _viewStatus = ViewStatusSupplier.success;
    } catch (e) {
      _errorMessage = e.toString();
      _viewStatus = ViewStatusSupplier.error;
    }

    notifyListeners();
  }
}
