import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/services/product_service.dart';

enum ViewStatusProduct { initial, loading, success, error }

class ProductProvider extends ChangeNotifier {
  static const int _pageSize = 10;
  static const int _searchPageSize = 10;

  final ProductService _productService;
  ProductProvider(this._productService);

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  List<ProductModel> get items =>
      filteredProducts; // Compatibilidad con la vista

  ViewStatusProduct _viewStatus = ViewStatusProduct.initial;
  ViewStatusProduct get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPage = 7;
  int get totalPage => _totalPage;
  int get totalPages => _totalPage;

  String _query = '';
  bool get isSearching => _query.isNotEmpty;

  bool? _selectedStatus;
  bool? get selectedStatus => _selectedStatus;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

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

  List<String> units = [];
  List<String> categories = [];
  List<String> suppliers = [];
  bool _catalogsLoaded = false;

  List<String> get availableUnits {
    final set = <String>{};
    set.addAll(units.where((u) => u.trim().isNotEmpty));
    set.addAll(
      _allProducts.map((p) => p.unitName.trim()).where((u) => u.isNotEmpty),
    );
    set.addAll(
      _products.map((p) => p.unitName.trim()).where((u) => u.isNotEmpty),
    );
    return set.toList()..sort();
  }

  List<String> get availableCategories {
    final set = <String>{};
    set.addAll(categories.where((c) => c.trim().isNotEmpty));
    set.addAll(
      _allProducts.map((p) => p.categoryName.trim()).where((c) => c.isNotEmpty),
    );
    set.addAll(
      _products.map((p) => p.categoryName.trim()).where((c) => c.isNotEmpty),
    );
    return set.toList()..sort();
  }

  List<String> get availableSuppliers {
    final set = <String>{};
    set.addAll(suppliers.where((s) => s.trim().isNotEmpty));
    set.addAll(
      _allProducts.map((p) => p.supplierName.trim()).where((s) => s.isNotEmpty),
    );
    set.addAll(
      _products.map((p) => p.supplierName.trim()).where((s) => s.isNotEmpty),
    );
    return set.toList()..sort();
  }

  Future<void> loadCatalogs() async {
    if (_catalogsLoaded) return;
    try {
      units = await _productService.getAllUnits().catchError((e) {
        debugPrint('Error cargando unidades: $e');
        return <String>[];
      });

      categories = await _productService.getAllCategories().catchError((e) {
        debugPrint('Error cargando categorías: $e');
        return <String>[];
      });

      suppliers = await _productService.getAllSuppliers().catchError((e) {
        debugPrint('Error cargando proveedores: $e');
        return <String>[];
      });

      if (units.isNotEmpty || categories.isNotEmpty || suppliers.isNotEmpty) {
        _catalogsLoaded = true;
      }
    } catch (e, stack) {
      debugPrint('ERROR CATALOGS: $e');
      debugPrint('$stack');
    }
    notifyListeners();
  }

  Future<void> loadCatalog() => loadCatalogs();

  Future<void> fetchProducts({int pageNumber = 1}) async {
    if (_viewStatus == ViewStatusProduct.loading) return;
    _viewStatus = ViewStatusProduct.loading;
    _errorMessage = null;

    notifyListeners();
    try {
      final dynamic result = await _productService.getAll(
        pageNumber: pageNumber,
        pageSize: _pageSize,
      );

      if (result is List<ProductModel>) {
        _products = result;
        _currentPage = pageNumber;
        if (result.length < _pageSize) {
          _totalPage = pageNumber > 1 ? pageNumber : 1;
        } else {
          _totalPage = pageNumber >= 7 ? pageNumber + 1 : 7;
        }
      } else {
        _products = result.items;
        _currentPage = result.pageNumber;
        _totalPage = result.totalPages;
      }

      _viewStatus = ViewStatusProduct.success;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusProduct.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusProduct.error;
    } catch (e, stack) {
      debugPrint('Error al obtener los productos: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
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
        final dynamic result = await _productService.getAll(
          pageNumber: page,
          pageSize: _searchPageSize,
        );
        if (result is List<ProductModel>) {
          all.addAll(result);
          if (result.length < _searchPageSize) break;
          totalPages = page + 1;
        } else {
          all.addAll(result.items);
          totalPages = result.totalPages;
        }
        page++;
      } while (page <= totalPages);
      _allProducts = all;
      _hasAllProducts = true;
    } catch (e, stack) {
      debugPrint('Error al cargar todos los productos: $e');
      debugPrint('$stack');
      _searchErrorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
    }
    _allProductsRequest = null;
    _isSearchLoading = false;
    notifyListeners();
  }

  Future<ProductModel?> register(ProductModel product) async {
    if (_isSaving) return null;

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    ProductModel? result;
    try {
      result = await _productService.createProduct(product);
      await refresh();
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('Error al registrar el producto: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
      _viewStatus = ViewStatusProduct.error;
    }

    _isSaving = false;
    notifyListeners();
    return result;
  }

  Future<ProductModel?> update(int productId, ProductModel product) async {
    if (_isSaving) return null;

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    ProductModel? result;
    try {
      result = await _productService.update(productId, product);
      await refresh();
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('Error al actualizar el producto: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
    }

    _isSaving = false;
    notifyListeners();
    return result;
  }

  Future<String?> delete(int productId) async {
    if (_isSaving) return null;
    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    String? message;
    try {
      message = await _productService.deleteProduct(productId, false);
      await refresh();
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('Error al eliminar el producto: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrio un error inesperado: Intentalo de nuevo';
    }
    _isSaving = false;
    notifyListeners();
    return message;
  }

  // Compatibilidad
  Future<bool> createProduct(ProductModel product) async {
    final result = await register(product);
    return result != null;
  }

  Future<bool> updateProduct(ProductModel product, [int? id]) async {
    final result = await update(id ?? product.productId, product);
    return result != null;
  }

  Future<bool> deleteProduct(int productId) async {
    final result = await delete(productId);
    return result != null;
  }
}
