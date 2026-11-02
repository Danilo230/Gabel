import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/purchase_model.dart';
import 'package:gabel/data/models/purchase_with_details_model.dart';
import 'package:gabel/services/purchase_service.dart';

enum PurchaseFilter { none, product, supplier, dateRange }
enum ViewStatusPurchase { initial, loading, success, error}

class PurchaseProvider extends ChangeNotifier {
  static const int _pageSize = 10;

  final PurchaseService _purchaseService;
  PurchaseProvider(this._purchaseService);

  List<PurchaseModel> _purchases = [];
  List<PurchaseModel> get purchases => _purchases;

  ViewStatusPurchase _viewStatus = ViewStatusPurchase.initial;
  ViewStatusPurchase get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPages = 1;
  int get totalPages => _totalPages;

  PurchaseFilter _filter = PurchaseFilter.none;
  PurchaseFilter get filter => _filter;
  bool get isFiltering => _filter != PurchaseFilter.none;

  int? _filterId;
  DateTime? _startDate;
  DateTime? _endDate;

  PurchaseWithDetailsModel? _selectedPurchase;
  PurchaseWithDetailsModel? get selectedPurchase => _selectedPurchase;

  ViewStatusPurchase _detailStatus = ViewStatusPurchase.initial;
  ViewStatusPurchase get detailStatus => _detailStatus;

  String? _detailErrorMessage;
  String? get detailErrorMessage => _detailErrorMessage;

  Future<void> fetchPurchases({int pageNumber = 1}) async {
    if (_viewStatus == ViewStatusPurchase.loading) return;

    _viewStatus = ViewStatusPurchase.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _fetchPage(pageNumber);
      _purchases = result.items;
      _currentPage = result.pageNumber;
      _totalPages = result.totalPages;
      _viewStatus = ViewStatusPurchase.success;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusPurchase.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusPurchase.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH PURCHASES: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _viewStatus = ViewStatusPurchase.error;
    }

    notifyListeners();
  }

  Future<void> refresh() => fetchPurchases(pageNumber: _currentPage);

  Future<PagedResultModel<PurchaseModel>> _fetchPage(int page) {
    switch (_filter) {
      case PurchaseFilter.product:
        return _purchaseService.getByProduct(
          _filterId!, 
          pageNumber: page,
          pageSize: _pageSize,
        );
      case PurchaseFilter.supplier:
        return _purchaseService.getBySupplier(
          _filterId!,
          pageNumber: page,
          pageSize: _pageSize,
        );
      case PurchaseFilter.dateRange:
        return _purchaseService.getByDateRange(
          startDate: _startDate!,
          endDate: _endDate!,
          pageNumber: page,
          pageSize: _pageSize,
        );
      case PurchaseFilter.none:
        return _purchaseService.getAll(pageNumber: page, pageSize: _pageSize);
    }
  }

  Future<void> filterByProduct(int productId) {
    _filter = PurchaseFilter.product;
    _filterId = productId;
    return fetchPurchases();
  }

  Future<void> filterBySupplier(int supplierId) {
    _filter = PurchaseFilter.supplier;
    _filterId = supplierId;
    return fetchPurchases();
  }

  Future<void> filterByDateRange(DateTime start, DateTime end) {
    _filter = PurchaseFilter.dateRange;
    _startDate = start;
    _endDate = end;
    return fetchPurchases();
  }

  Future<void> clearFilter() {
    _filter = PurchaseFilter.none;
    _filterId = null;
    _startDate = null;
    _endDate = null;
    return fetchPurchases();
  }

  Future<void> fetchPurchaseDetail(int purchaseId) async {
    _detailStatus = ViewStatusPurchase.loading;
    _detailErrorMessage = null;
    _selectedPurchase = null;
    notifyListeners();

    try {
      _selectedPurchase = await _purchaseService.getById(purchaseId);
      _detailStatus = ViewStatusPurchase.success;
    } on ServerException catch (e) {
      _detailErrorMessage =
          e.statusCode == 404 ? 'Compra no encontrada' : e.message;
      _detailStatus = ViewStatusPurchase.error;
    } on AppException catch (e) {
      _detailErrorMessage = e.message;
      _detailStatus = ViewStatusPurchase.error;
    } on FormatException catch (e) {
      _detailErrorMessage = e.message;
      _detailStatus = ViewStatusPurchase.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH PURCHASE DETAIL: $e');
      debugPrint('$stack');
      _detailErrorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _detailStatus = ViewStatusPurchase.error;
    }

    notifyListeners();
  }

  void clearDetail() {
    _selectedPurchase = null;
    _detailStatus = ViewStatusPurchase.initial;
    _detailErrorMessage = null;
    notifyListeners();
  }
}