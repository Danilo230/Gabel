import 'package:gabel/data/repositories/product_repository.dart';
import 'package:gabel/data/models/product_model.dart';

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
    return await _productRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  Future<ProductModel> create(ProductModel product) async {
    final name = product.productName.trim();
    final description = product.productDescription.trim();
    final brand = product.productBrand.trim();
    final unit = product.productUnit.trim();
    final category = product.productCategory.trim();
    final supplier = product.productSupplier.trim();
    final price = product.productPrice.trim();

    if (name.isEmpty || price.isEmpty) {
      throw Exception('Los parámetros no pueden estar vacios');
    }

    return await _productRepository.create(
      ProductModel(
        productId: product.productId,
        productName: name,
        productDescription: description,
        productBrand: brand,
        productUnit: unit,
        productCategory: category,
        productSupplier: supplier,
        productPrice: price,
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
    final price = product.productPrice.trim();

    if (name.isEmpty || price.isEmpty) {
      throw Exception('Los parámetros no pueden estar vacios');
    }

    return await _productRepository.create(
      ProductModel(
        productId: productId,
        productName: name,
        productDescription: description,
        productBrand: brand,
        productUnit: unit,
        productCategory: category,
        productSupplier: supplier,
        productPrice: price,
        productStatus: product.productStatus,
      ),
    );
  }

  Future<String> delete(int productId, bool productStatus) async {
    if (productId <= 0) {
      throw Exception('Id de producto no es válido');
    }
    return await _productRepository.delete(productId, productStatus);
  }
}
