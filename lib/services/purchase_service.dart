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
    _validatePaging(pageNumber, pageSize);

    return _purchaseRepository.getAll(
      params: _pagingParams(pageNumber, pageSize),
    );
  }

  Future<PurchaseWithDetailsModel> getById(int purchaseId) async {
    return _purchaseRepository.getById(purchaseId);
  }

  Future<PagedResultModel<PurchaseModel>> getByDateRange({
    required DateTime startDate,
    required DateTime endDate,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    _validatePaging(pageNumber, pageSize);
    _validateDates(startDate, endDate);

    return _purchaseRepository.getByDateRange(
      startDate: startDate,
      endDate: endDate,
      params: _pagingParams(pageNumber, pageSize),
    );
  }

  Future<PagedResultModel<PurchaseModel>> getBySupplier(
    int supplierId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    _validatePaging(pageNumber, pageSize);

    return _purchaseRepository.getBySupplier(
      supplierId,
      params: _pagingParams(pageNumber, pageSize),
    );
  }

  Future<PagedResultModel<PurchaseModel>> getByProduct(
    int productId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    _validatePaging(pageNumber, pageSize);

    return _purchaseRepository.getByProduct(
      productId,
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