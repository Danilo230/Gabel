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
    _validatePaging(pageNumber, pageSize);

    return _saleRepository.getAll(
      params: _pagingParams(pageNumber, pageSize),
    );
  }

  Future<SaleWithDetailsModel> getById(int saleId) async {
    return _saleRepository.getById(saleId);
  }

  Future<PagedResultModel<SaleModel>> getByDateRange({
    required DateTime startDate,
    required DateTime endDate,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    _validatePaging(pageNumber, pageSize);
    _validateDates(startDate, endDate);

    return _saleRepository.getByDateRange(
      startDate: startDate,
      endDate: endDate,
      params: _pagingParams(pageNumber, pageSize),
    );
  }

  Future<PagedResultModel<SaleModel>> getByProduct(
    int productId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    _validatePaging(pageNumber, pageSize);

    return _saleRepository.getByProduct(
      productId,
      params: _pagingParams(pageNumber, pageSize),
    );
  }

  Future<PagedResultModel<SaleModel>> getByService(
    int serviceId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    _validatePaging(pageNumber, pageSize);

    return _saleRepository.getByService(
      serviceId,
      params: _pagingParams(pageNumber, pageSize),
    );
  }

  void _validatePaging(int pageNumber, int pageSize) {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }
  }

  void _validateDates(DateTime startDate, DateTime endDate) {
    if (startDate.isAfter(endDate)) {
      throw const FormatException(
        'La fecha de inicio no puede ser mayor que la fecha de fin',
      );
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final endDay = DateTime(endDate.year, endDate.month, endDate.day);
    if (endDay.isAfter(today)) {
      throw const FormatException(
        'No se permiten fechas futuras en la consulta',
      );
    }
  }

  Map<String, String> _pagingParams(int pageNumber, int pageSize) => {
        'pageNumber': pageNumber.toString(),
        'pageSize': pageSize.toString(),
      };
}