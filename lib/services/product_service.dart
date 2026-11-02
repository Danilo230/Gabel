import 'package:gabel/data/repositories/product_repository.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/core/constants/api_constants.dart';

class ProductService {
  final ProductRepository _productRepository;

  ProductService(this._productRepository);

  Future<ProductModel> getById(int productId) async {
    return await _productRepository.getById(productId);
  }

  Future<List<ProductModel>> getAll({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }
    return await _productRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    final name = product.productName.trim();
    final description = product.productDescription.trim();
    final brand = product.productBrand.trim();
    final unit = product.productUnit.trim();
    final category = product.productCategory.trim();
    final supplier = product.productSupplier.trim();

    if (name.isEmpty ||
        brand.isEmpty ||
        unit.isEmpty ||
        category.isEmpty ||
        supplier.isEmpty) {
      throw Exception('Todos los campos son obligatorios.');
    }

    return await _productRepository.createProduct(
      ProductModel(
        productId: product.productId,
        productName: name,
        productDescription: description,
        productBrand: brand,
        productUnit: unit,
        productCategory: category,
        productSupplier: supplier,
        productStatus: true,
      ),
    );
  }

  Future<ProductModel> update(int productId, ProductModel product) async {
    final name = product.productName.trim();
    final description = product.productDescription.trim();
    final brand = product.productBrand.trim();
    final unit = product.productUnit.trim();
    final category = product.productCategory.trim();
    final supplier = product.productSupplier.trim();

    if (name.isEmpty ||
        brand.isEmpty ||
        unit.isEmpty ||
        category.isEmpty ||
        supplier.isEmpty) {
      throw Exception('Todos los campos son obligatorios.');
    }

    return await _productRepository.updateProduct(
      productId,
      ProductModel(
        productId: productId,
        productName: name,
        productDescription: description,
        productBrand: brand,
        productUnit: unit,
        productCategory: category,
        productSupplier: supplier,
        productStatus: product.productStatus,
      ),
    );
  }

  Future<String> deleteProduct(int productId, bool productStatus) async {
    if (productId <= 0) {
      throw Exception('Id de producto no es válido');
    }
    return await _productRepository.deleteProduct(productId, productStatus);
  }

  Future<List<String>> getBrands() =>
      _productRepository.getCatalog(ApiConstants.productBrands, '');

  Future<List<String>> getUnits() =>
      _productRepository.getCatalog(ApiConstants.productUnits, '');

  Future<List<String>> getCategories() =>
      _productRepository.getCatalog(ApiConstants.productCategories, '');

  Future<List<String>> getSuppliers() =>
      _productRepository.getCatalog(ApiConstants.productSuppliers, '');
}
