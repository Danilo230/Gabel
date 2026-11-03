import 'package:gabel/core/errors/app_exception.dart';

class PagedResultModel<T> {
  final List<T> items;
  final int totalRecords;
  final int pageNumber;
  final int pageSize;

  const PagedResultModel({
    required this.items,
    required this.totalRecords,
    required this.pageNumber,
    required this.pageSize,
  });

  int get totalPages =>
      pageSize <= 0 || totalRecords <= 0 ? 1 : (totalRecords / pageSize).ceil();

  factory PagedResultModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) itemFromJson,
  ) {
    final items = json['items'];
    if (items is! List) throw const ParsingException();

    return PagedResultModel(
      items: items
          .map((item) => itemFromJson(item as Map<String, dynamic>))
          .toList(),
      totalRecords: (json['totalRecords'] as num).toInt(),
      pageNumber: (json['pageNumber'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
    );
  }
}
