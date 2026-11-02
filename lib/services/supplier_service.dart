
import 'package:gabel/data/models/supplier_model.dart';
import 'package:gabel/data/repositories/supplier_repository.dart';

class SupplierService {
  final SupplierRepository _supplierRepository;

  SupplierService(this._supplierRepository);

  Future<List<SupplierModel>> getAll({
    int pageNumber = 1,
    int pageSize = 100,
  }) async {
    return await _supplierRepository.getAll(
      params: {
        'pageNumber': pageNumber.toString(),
        'pageSize': pageSize.toString(),
      },
    );
  }
}
