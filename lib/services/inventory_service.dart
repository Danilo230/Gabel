import 'package:gabel/data/models/inventory_model.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/repositories/inventory_repository.dart';

class InventoryService {
  final InventoryRepository _inventoryRepository;

  InventoryService(this._inventoryRepository);

  Future<PagedResultModel<InventoryModel>> getAll({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }

    return await _inventoryRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }
}
