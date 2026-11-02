import 'package:gabel/data/models/damaged_product_model.dart';
import 'package:gabel/data/repositories/damaged_product_repository.dart';

class DamagedProductService {
  final DamagedProductRepository _damagedProductRepository;

  DamagedProductService(this._damagedProductRepository);

  Future<List<DamagedProductModel>> getAll() async {
    return await _damagedProductRepository.getAll();
  }

  Future<DamagedProductModel> create(
    CreateDamagedProductModel damagedProduct,
  ) async {
    final reason = damagedProduct.damageReason.trim();

    if (damagedProduct.inventoryId <= 0) {
      throw const FormatException('Id del inventario no es válido');
    }
    if (damagedProduct.quantity <= 0) {
      throw const FormatException('La cantidad dañada debe ser mayor a 0');
    }
    if (reason.isEmpty) {
      throw const FormatException('El motivo del daño es requerido');
    }

    return await _damagedProductRepository.create(
      CreateDamagedProductModel(
        inventoryId: damagedProduct.inventoryId,
        stylistId: damagedProduct.stylistId,
        quantity: damagedProduct.quantity,
        damageReason: reason,
      ),
    );
  }
}
