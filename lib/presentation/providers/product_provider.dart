import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/services/product_service.dart';

enum ViewStatusProduct { initial, loading, success, error }

class ProductProvider extends ChangeNotifier {
  static const int _pageSize = 10;

  final ProductService _productService;
  ProductProvider(this._productService);

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  List<ProductModel> get items => filteredProducts;

  ViewStatusProduct _viewStatus = ViewStatusProduct.initial;
  ViewStatusProduct get viewStatus => _viewStatus;

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

  List<ProductModel> _allProducts = [];
  bool _hasAllProducts = false;
  Future<void>? _allProductsRequest;

  bool _isSearchLoading = false;
  bool get isSearchLoading => _isSearchLoading;

  String? _searchErrorMessage;
  String? get searchErrorMessage => _searchErrorMessage;

  List<ProductModel> get filteredProducts {
    if (_query.isNotEmpty) {
      return _allProducts.where((product) {
        return product.productName.toLowerCase().contains(_query) ||
            product.brand.toLowerCase().contains(_query);
      }).toList();
    }
    if (_selectedStatus != null) {
      return _allProducts.where((product) {
        return product.productStatus == _selectedStatus;
      }).toList();
    }
    return _products;
  }

  List<CatalogItem> units = [];
  List<CatalogItem> categories = [];
  List<CatalogItem> suppliers = [];
  bool _catalogsLoaded = false;

  String? _catalogError;
  String? get catalogError => _catalogError;

  List<String> get availableUnits => units.map((e) => e.name).toList();
  List<String> get availableCategories =>
      categories.map((e) => e.name).toList();
  List<String> get availableSuppliers => suppliers.map((e) => e.name).toList();

  int _idByName(List<CatalogItem> list, String name) {
    final target = name.trim().toLowerCase();
    for (final item in list) {
      if (item.name.trim().toLowerCase() == target) return item.id;
    }
    return 0;
  }

  int unitIdByName(String name) => _idByName(units, name);
  int categoryIdByName(String name) => _idByName(categories, name);
  int supplierIdByName(String name) => _idByName(suppliers, name);

  Future<void> loadCatalogs() async {
    if (_catalogsLoaded) return;
    try {
      final results = await Future.wait([
        _productService.getAllUnits(),
        _productService.getAllCategories(),
        _productService.getAllSuppliers(),
      ]);
      units = results[0];
      categories = results[1];
      suppliers = results[2];

      _catalogsLoaded =
          units.isNotEmpty && categories.isNotEmpty && suppliers.isNotEmpty;
      _catalogError = _catalogsLoaded
          ? null
          : 'No se encontraron opciones en el catálogo.';
    } catch (e) {
      debugPrint('Error al cargar los catálogos: $e');
      _catalogError = e is AppException
          ? e.message
          : 'No se pudieron cargar las opciones.';
    }
    notifyListeners();
  }

  Future<void> fetchProducts({int pageNumber = 1}) async {
    if (_viewStatus == ViewStatusProduct.loading) return;
    _viewStatus = ViewStatusProduct.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _productService.getAll(
        pageNumber: pageNumber,
        pageSize: _pageSize,
      );
      _products = result.items;
      _currentPage = result.pageNumber;
      _totalPage = result.totalPages;
      _viewStatus = ViewStatusProduct.success;
      loadCatalogs();
    } catch (e) {
      _errorMessage = _messageFrom(e);
      _viewStatus = ViewStatusProduct.error;
    }
    notifyListeners();
  }

  Future<void> refresh() async {
    _hasAllProducts = false;
    await fetchProducts(pageNumber: _currentPage);
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

  void clearFilters() {
    _selectedStatus = null;
    _query = '';
    notifyListeners();
  }

  Future<void> retrySearch() {
    _hasAllProducts = false;
    _allProductsRequest = null;
    return _loadAllItems();
  }

  Future<void> _loadAllItems() {
    if (_hasAllProducts) return Future.value();
    return _allProductsRequest ??= _fetchAllItems();
  }

  Future<void> _fetchAllItems() async {
    _isSearchLoading = true;
    _searchErrorMessage = null;
    notifyListeners();

    try {
      final List<ProductModel> all = [];
      int page = 1;
      int totalPages = 1;
      do {
        final result = await _productService.getAll(
          pageNumber: page,
          pageSize: _pageSize,
        );
        all.addAll(result.items);
        totalPages = result.totalPages;
        page++;
      } while (page <= totalPages);

      _allProducts = all;
      _hasAllProducts = true;
    } catch (e) {
      _searchErrorMessage = _messageFrom(e);
    }
    _allProductsRequest = null;
    _isSearchLoading = false;
    notifyListeners();
  }

  Future<ProductModel?> register(ProductModel product) {
    return _save(() async {
      final created = await _productService.createProduct(product);
      _currentPage = 1;
      await refresh();
      return created;
    });
  }

  Future<ProductModel?> update(int productId, ProductModel product) {
    return _save(() async {
      final updated = await _productService.updateProduct(productId, product);
      await refresh();
      return updated;
    });
  }

  Future<String?> delete(int productId) {
    return _save(() async {
      final message = await _productService.delete(productId, false);
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
