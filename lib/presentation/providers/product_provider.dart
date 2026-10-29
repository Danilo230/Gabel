import 'package:flutter/material.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/services/product_service.dart';

enum ViewStatusProduct { initial, loading, success, error }

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _product = [];
  List<ProductModel> get Product => _product;

  ViewStatusProduct _viewStatus = ViewStatusProduct.initial;
  ViewStatusProduct get ViewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final ProductService _productService;
  ProductProvider(this._productService);

  Future<void> fetchProduct() async {
    _viewStatus = ViewStatusProduct.loading;
    notifyListeners();
  }
}
