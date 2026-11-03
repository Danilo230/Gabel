import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/damaged_product_model.dart';
import 'package:gabel/presentation/providers/user_provider.dart' show ViewStatus;
import 'package:gabel/services/damaged_product_service.dart';

class DamagedProductProvider extends ChangeNotifier {
  final DamagedProductService _damagedProductService;
  DamagedProductProvider(this._damagedProductService);

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  List<DamagedProductModel> _history = [];
  List<DamagedProductModel> get history => _history;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  Future<void> fetchHistory() async {
    if (_viewStatus == ViewStatus.loading) return;

    _viewStatus = ViewStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _history = await _damagedProductService.getAll();
      _viewStatus = ViewStatus.success;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH DAMAGED PRODUCTS: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _viewStatus = ViewStatus.error;
    }

    notifyListeners();
  }

  Future<DamagedProductModel?> register(CreateDamagedProductModel damagedProduct) async {
    if (_isSaving) return null;

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    DamagedProductModel? result;
    try {
      result = await _damagedProductService.create(damagedProduct);
    } on ServerException catch (e) {
      _errorMessage = e.statusCode == 403
          ? 'No tienes permiso para registrar productos dañados.'
          : 'No se pudo registrar el producto dañado. Inténtalo de nuevo.';
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('ERROR REGISTER DAMAGED PRODUCT: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
    }

    _isSaving = false;
    notifyListeners();
    return result;
  }
}
