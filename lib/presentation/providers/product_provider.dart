import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/presentation/providers/user_provider.dart'
    show ViewStatus;
import 'package:gabel/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  static const int _pageSize = 10;

  final ProductService _productService;
  ProductProvider(this._productService);

  List<ProductModel> _items = [];
  List<ProductModel> get items => _items;

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

  List<String> brands = [];
  List<String> units = [];
  List<String> categories = [];
  List<String> suppliers = [];
  bool _catalogsLoaded = false;

  Future<void> loadCatalogs() async {
    if (_catalogsLoaded) return;
    try {
      final results = await Future.wait([
        _productService.getBrands(),
        _productService.getUnits(),
        _productService.getCategories(),
        _productService.getSuppliers(),
      ]);

      brands = results[0];
      units = results[1];
      categories = results[2];
      suppliers = results[3];
      _catalogsLoaded = true;
    } on AppException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('ERROR CATALOGS: $e');
      debugPrint('$stack');
      _errorMessage = 'No se pudieron cargar las opciones.';
    }
    notifyListeners();
  }

  Future<void> fetchProducts({int pageNumber = 1}) async {
    if (_viewStatus == ViewStatus.loading) return;

    _viewStatus = ViewStatus.loading;
    _errorMessage = null;
    _productCache.clear();
    notifyListeners();

    try {
      final result = await _productService.getAll(
        pageNumber: pageNumber,
        pageSize: _pageSize,
      );

      _items = result;
      _currentPage = pageNumber;
      _totalPages = totalPages;
      _viewStatus = ViewStatus.success;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH PRODUCTS: $e');
      debugPrint('$stack');
      _errorMessage =
          'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _viewStatus = ViewStatus.error;
    }

    notifyListeners();
  }

  Future<void> refresh() => fetchProducts(pageNumber: _currentPage);

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
      _productErrorMessage =
          'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
    }

    return null;
  }

  Future<bool> createProduct(ProductModel product) async {
    _viewStatus = ViewStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final newProduct = await _productService.createProduct(product);
      _items.insert(0, newProduct);
      if (newProduct.productId != null) {
        _productCache[newProduct.productId!] = newProduct;
      }
      _viewStatus = ViewStatus.success;
      notifyListeners();
      return true;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } catch (e, stack) {
      debugPrint('ERROR CREATE PRODUCT: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error al crear el producto.';
      _viewStatus = ViewStatus.error;
    }

    notifyListeners();
    return false;
  }

  Future<bool> updateProduct(int productId, ProductModel product) async {
    _viewStatus = ViewStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final updated = await _productService.update(productId, product);
      final index = _items.indexWhere((p) => p.productId == productId);
      if (index != -1) {
        _items[index] = updated;
      }
      _productCache[productId] = updated;
      _viewStatus = ViewStatus.success;
      notifyListeners();
      return true;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } catch (e, stack) {
      debugPrint('ERROR UPDATE PRODUCT: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error al actualizar el producto.';
      _viewStatus = ViewStatus.error;
    }

    notifyListeners();
    return false;
  }

  Future<bool> deleteProduct(int productId) async {
    _errorMessage = null;
    try {
      await _productService.deleteProduct(productId, false);
      _productCache.remove(productId);
      await fetchProducts(pageNumber: _currentPage);
      return true;
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e, stack) {
      debugPrint('ERROR DEACTIVATE PRODUCT: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error al eliminar el producto.';
    }
    notifyListeners();
    return false;
  }
}
