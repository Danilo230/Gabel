import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/stylist_model.dart';
import 'package:gabel/data/repositories/stylist_repository.dart';

class StylistService {
  static const int _allPagesSize = 50;

  final StylistRepository _stylistRepository;

  StylistService(this._stylistRepository);

  Future<PagedResultModel<StylistModel>> getAll({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }

    return await _stylistRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    });
  }

  Future<List<StylistModel>> getAllPages() async {
    final List<StylistModel> all = [];
    int page = 1;
    int totalPages = 1;

    do {
      final result = await getAll(pageNumber: page, pageSize: _allPagesSize);
      all.addAll(result.items);
      totalPages = result.totalPages;
      page++;
    } while (page <= totalPages);

    return all;
  }

  Future<StylistModel> getById(int stylistId) async {
    if (stylistId <= 0) {
      throw const FormatException('Id de estilista no es válido');
    }

    return await _stylistRepository.getById(stylistId);
  }

  Future<StylistModel> getByName(String name) async {
    final trimmed = name.trim();

    if (trimmed.isEmpty) {
      throw const FormatException('El nombre del estilista es requerido');
    }

    return await _stylistRepository.getByName(trimmed);
  }
}
