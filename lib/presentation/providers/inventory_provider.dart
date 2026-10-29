import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/inventory_model.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/presentation/providers/user_provider.dart' show ViewStatus;
import 'package:gabel/services/inventory_service.dart';
import 'package:gabel/services/product_service.dart';

class InventoryProvider extends ChangeNotifier {
  static const int _pageSize = 10;

  final InventoryService _inventoryService;
  final ProductService _productService;
  InventoryProvider(this._inventoryService, this._productService);

  List<InventoryModel> _items = [];
  List<InventoryModel> get items => _items;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPages = 1;
  int get totalPages => _totalPages;

  final Map<int, ProductModel> _productCache = {};

  String? _productErrorMessage;
  String? get productErrorMessage => _productErrorMessage;

  Future<void> fetchInventory({int pageNumber = 1}) async {
    if (_viewStatus == ViewStatus.loading) return;

    _viewStatus = ViewStatus.loading;
    _errorMessage = null;
    _productCache.clear();
    notifyListeners();

    try {
      final result = await _inventoryService.getAll(
        pageNumber: pageNumber,
        pageSize: _pageSize,
      );
      _items = result.items;
      _currentPage = result.pageNumber;
      _totalPages = result.totalPages;
      _viewStatus = ViewStatus.success;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH INVENTORY: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _viewStatus = ViewStatus.error;
    }

    notifyListeners();
  }

  Future<void> refresh() => fetchInventory(pageNumber: _currentPage);

  Future<ProductModel?> fetchProduct(int productId) async {
    final cached = _productCache[productId];
    if (cached != null) return cached;

    _productErrorMessage = null;

    try {
      final product = await _productService.getById(productId);
      _productCache[productId] = product;
      return product;
    } on AppException catch (e) {
      _productErrorMessage = e.message;
    } on FormatException catch (e) {
      _productErrorMessage = e.message;
    } catch (e, stack) {
      debugPrint('ERROR FETCH PRODUCT: $e');
      debugPrint('$stack');
      _productErrorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
    }

    return null;
  }
}