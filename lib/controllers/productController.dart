import 'package:flutter/material.dart';
import '../../presentation/screens/products/models/productmodel.dart';
import '../data/repositories/product_repository.dart';

class ProductController extends ChangeNotifier {
  final ProductRepository _repository;

  ProductController({ProductRepository? repository})
      : _repository = repository ?? ProductRepository();

  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await _repository.getProducts();
    } catch (e) {
      _errorMessage = 'Error al cargar productos: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addProduct(ProductModel product) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newProduct = await _repository.createProduct(product);
      _products.add(newProduct);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'No se pudo crear el producto: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _repository.deleteProduct(id);
      _products.removeWhere((p) => p.productId == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al eliminar: $e';
      notifyListeners();
    }
  }
}