import 'package:flutter/material.dart';
import 'package:gabel/data/models/service_models.dart';
import 'package:gabel/services/services_service.dart';

enum ViewStatusService { initial, loading, success, error }

class ServiceProvider extends ChangeNotifier {
  List<ServiceModels> _service = [];
  List<ServiceModels> get service => _service;

  ViewStatusService _viewStatus = ViewStatusService.initial;
  ViewStatusService get ViewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final ServicesService _servicesService;
  ServiceProvider(this._servicesService);

  Future<void> fetchService() async {
    _viewStatus = ViewStatusService.loading;
    notifyListeners();
  }
}
