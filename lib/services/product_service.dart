import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/data/repositories/product_repository.dart';

class ProductService {
  final ProductRepository _productRepository;

  ProductService(this._productRepository);

  Future<ProductModel> getById(int productId) async {
    return await _productRepository.getById(productId);
  }

  Future<PagedResultModel<ProductModel>> getAll({
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

  ProductModel _clean(int productId, ProductModel product, bool status) {
    final name = product.productName.trim();
    final brand = product.brand.trim();
    final unit = product.unitName.trim();
    final category = product.categoryName.trim();
    final supplier = product.supplierName.trim();

    if (name.isEmpty ||
        brand.isEmpty ||
        unit.isEmpty ||
        category.isEmpty ||
        supplier.isEmpty) {
      throw const FormatException('Todos los campos son obligatorios.');
    }

    return ProductModel(
      productId: productId,
      productName: name,
      productDescription: product.productDescription.trim(),
      brand: brand,
      productStatus: status,
      unitId: product.unitId,
      unitName: unit,
      categoryId: product.categoryId,
      categoryName: category,
      supplierId: product.supplierId,
      supplierName: supplier,
    );
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    return await _productRepository.create(
      _clean(product.productId, product, true),
    );
  }

  Future<ProductModel> updateProduct(
    int productId,
    ProductModel product,
  ) async {
    return await _productRepository.updateProduct(
      productId,
      _clean(productId, product, product.productStatus),
    );
  }

  Future<String> delete(int productId, bool productStatus) async {
    if (productId <= 0) {
      throw const FormatException('Id de producto no es válido');
    }
    return await _productRepository.delete(productId, productStatus);
  }

  Future<List<CatalogItem>> getAllUnits() => _productRepository.getAllCatalog(
    ApiConstants.units,
    idKey: 'unitId',
    nameKey: 'unitName',
  );

  Future<List<CatalogItem>> getAllCategories() =>
      _productRepository.getAllCatalog(
        ApiConstants.categories,
        idKey: 'categoryId',
        nameKey: 'categoryName',
      );

  Future<List<CatalogItem>> getAllSuppliers() =>
      _productRepository.getAllCatalog(
        ApiConstants.suppliers,
        idKey: 'supplierId',
        nameKey: 'supplierName',
      );
}
