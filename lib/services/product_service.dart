import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/data/repositories/product_repository.dart';

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

  Future<ProductModel> create(ProductModel product) async {
    final name = product.productName.trim();
    final description = product.productDescription.trim(); // Opcional
    final brand = product.brand.trim();
    final unit = product.unitName.trim();
    final category = product.categoryName.trim();
    final supplier = product.supplierName.trim();

    // Todos los campos son obligatorios excepto la descripción
    if (name.isEmpty ||
        brand.isEmpty ||
        unit.isEmpty ||
        category.isEmpty ||
        supplier.isEmpty) {
      throw Exception('Los parámetros no pueden estar vacios');
    }

    return await _productRepository.createProduct(
      ProductModel(
        productId: product.productId,
        productName: name,
        productDescription: description,
        brand: brand,
        unitName: unit,
        categoryName: category,
        supplierName: supplier,
        productStatus: true,
      ),
    );
  }

  Future<ProductModel> update(int productId, ProductModel product) async {
    final name = product.productName.trim();
    final description = product.productDescription.trim(); // Opcional
    final brand = product.brand.trim();
    final unit = product.unitName.trim();
    final category = product.categoryName.trim();
    final supplier = product.supplierName.trim();

    // Todos los campos son obligatorios excepto la descripción
    if (name.isEmpty ||
        brand.isEmpty ||
        unit.isEmpty ||
        category.isEmpty ||
        supplier.isEmpty) {
      throw Exception('Los parámetros no pueden estar vacios');
    }

    return await _productRepository.updateProduct(
      productId,
      ProductModel(
        productId: productId,
        productName: name,
        productDescription: description,
        brand: brand,
        unitName: unit,
        categoryName: category,
        supplierName: supplier,
        productStatus: product.productStatus,
      ),
    );
  }

  Future<String> delete(int productId, bool productStatus) async {
    if (productId <= 0) {
      throw Exception('Id de producto no es válido');
    }
    return await _productRepository.deleteProduct(productId, productStatus);
  }

  Future<ProductModel> createProduct(ProductModel product) => create(product);
  Future<String> deleteProduct(int productId, bool productStatus) =>
      delete(productId, productStatus);

  Future<List<String>> getAllUnits() =>
      _productRepository.getAllCatalog(ApiConstants.productUnits, 'unitName');

  Future<List<String>> getAllCategories() => _productRepository.getAllCatalog(
    ApiConstants.productCategories,
    'categoryName',
  );

  Future<List<String>> getAllSuppliers() => _productRepository.getAllCatalog(
    ApiConstants.productSuppliers,
    'supplierName',
  );
}
