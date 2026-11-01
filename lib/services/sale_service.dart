import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/sale_model.dart';
import 'package:gabel/data/models/sale_with_details_model.dart';
import 'package:gabel/data/repositories/sale_repository.dart';

class SaleService {
  final SaleRepository _saleRepository;

  SaleService(this._saleRepository);

  Future<PagedResultModel<SaleModel>> getAll({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }

    return await _saleRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  Future<SaleWithDetailsModel> getById(int saleId) async {
    return await _saleRepository.getById(saleId);
  }

  Future<PagedResultModel<SaleModel>> getByDateRange({
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

    return await _saleRepository.getByDateRange(
      startDate: startDate,
      endDate: endDate,
      params: {
        'pageNumber': pageNumber.toString(),
        'pageSize': pageSize.toString(),
      },
    );
  }

  Future<PagedResultModel<SaleModel>> getByProduct(int productId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }

    return await _saleRepository.getByProduct(productId, params: {
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  Future<PagedResultModel<SaleModel>> getByService(int serviceId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }

    return await _saleRepository.getByService(serviceId, params: {
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

}