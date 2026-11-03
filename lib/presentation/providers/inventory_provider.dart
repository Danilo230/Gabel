import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/inventory_model.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/presentation/providers/user_provider.dart' show ViewStatus;
import 'package:gabel/services/inventory_service.dart';
import 'package:gabel/services/product_service.dart';

class InventoryProvider extends ChangeNotifier {
  static const int _pageSize = 10;
  static const int _searchPageSize = 50;

  final InventoryService _inventoryService;
  final ProductService _productService;
  InventoryProvider(this._inventoryService, this._productService);

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

  String _query = '';
  bool get isSearching => _query.isNotEmpty;

  List<InventoryModel> _allItems = [];
  bool _hasAllItems = false;
  Future<void>? _allItemsRequest;

  bool _isSearchLoading = false;
  bool get isSearchLoading => _isSearchLoading;

  String? _searchErrorMessage;
  String? get searchErrorMessage => _searchErrorMessage;

  List<InventoryModel> get filteredItems {
    if (_query.isEmpty) return _items;
    return _allItems
        .where((item) => item.productName.toLowerCase().contains(_query))
        .toList();
  }

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

  Future<void> refresh() async {
    _hasAllItems = false;
    await fetchInventory(pageNumber: _currentPage);
    if (_query.isNotEmpty) await _loadAllItems();
  }

  Future<void> search(String query) async {
    _query = query.trim().toLowerCase();
    notifyListeners();
    if (_query.isNotEmpty) await _loadAllItems();
  }

  Future<void> retrySearch() => _loadAllItems();

  Future<void> _loadAllItems() {
    if (_hasAllItems) return Future.value();
    return _allItemsRequest ??= _fetchAllItems();
  }

  Future<void> _fetchAllItems() async {
    _isSearchLoading = true;
    _searchErrorMessage = null;
    notifyListeners();

    try {
      final List<InventoryModel> all = [];
      int page = 1;
      int totalPages = 1;

      do {
        final result = await _inventoryService.getAll(
          pageNumber: page,
          pageSize: _searchPageSize,
        );
        all.addAll(result.items);
        totalPages = result.totalPages;
        page++;
      } while (page <= totalPages);

      _allItems = all;
      _hasAllItems = true;
    } on AppException catch (e) {
      _searchErrorMessage = e.message;
    } on FormatException catch (e) {
      _searchErrorMessage = e.message;
    } catch (e, stack) {
      debugPrint('ERROR FETCH ALL INVENTORY: $e');
      debugPrint('$stack');
      _searchErrorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
    }

    _allItemsRequest = null;
    _isSearchLoading = false;
    notifyListeners();
  }

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