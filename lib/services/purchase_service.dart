import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/purchase_model.dart';
import 'package:gabel/data/models/purchase_with_details_model.dart';
import 'package:gabel/data/repositories/purchase_repository.dart';

class PurchaseService {
  final PurchaseRepository _purchaseRepository;

  PurchaseService(this._purchaseRepository);

  Future<PagedResultModel<PurchaseModel>> getAll({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }

    return await _purchaseRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  Future<PurchaseWithDetailsModel> getById(int purchaseId) async {
    return await _purchaseRepository.getById(purchaseId);
  }

  Future<PagedResultModel<PurchaseModel>> getByDateRange({
    required DateTime startDate,
    required DateTime endDate,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }

    return await _purchaseRepository.getByDateRange(
      startDate: startDate,
      endDate: endDate,
      params: {
        'pageNumber': pageNumber.toString(),
        'pageSize': pageSize.toString(),
      },
    );
  }

  Future<PagedResultModel<PurchaseModel>> getBySupplier(int supplierId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }

    return await _purchaseRepository.getBySupplier(supplierId, params: {
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  Future<PagedResultModel<PurchaseModel>> getByProduct(int productId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }

    return await _purchaseRepository.getByProduct(productId, params: {
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

}