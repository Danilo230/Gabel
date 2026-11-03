import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/models/sale_model.dart';
import 'package:gabel/data/models/sale_with_details_model.dart';
import 'package:gabel/services/sale_service.dart';

enum SaleFilter { none, product, service, dateRange }
enum ViewStatusSale { initial, loading, success, error}

class SaleProvider extends ChangeNotifier {
  static const int _pageSize = 10;

  final SaleService _saleService;
  SaleProvider(this._saleService);

  List<SaleModel> _sales = [];
  List<SaleModel> get sales => _sales;

  ViewStatusSale _viewStatus = ViewStatusSale.initial;
  ViewStatusSale get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPages = 1;
  int get totalPages => _totalPages;

  SaleFilter _filter = SaleFilter.none;
  SaleFilter get filter => _filter;
  bool get isFiltering => _filter != SaleFilter.none;

  int? _filterId;
  DateTime? _startDate;
  DateTime? _endDate;

  SaleWithDetailsModel? _selectedSale;
  SaleWithDetailsModel? get selectedSale => _selectedSale;

  ViewStatusSale _detailStatus = ViewStatusSale.initial;
  ViewStatusSale get detailStatus => _detailStatus;

  String? _detailErrorMessage;
  String? get detailErrorMessage => _detailErrorMessage;

  Future<void> fetchSales({int pageNumber = 1}) async {
    if (_viewStatus == ViewStatusSale.loading) return;

    _viewStatus = ViewStatusSale.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _fetchPage(pageNumber);
      _sales = result.items;
      _currentPage = result.pageNumber;
      _totalPages = result.totalPages;
      _viewStatus = ViewStatusSale.success;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusSale.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusSale.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH SALES: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _viewStatus = ViewStatusSale.error;
    }

    notifyListeners();
  }

  Future<void> refresh() => fetchSales(pageNumber: _currentPage);

  Future<PagedResultModel<SaleModel>> _fetchPage(int page) {
    switch (_filter) {
      case SaleFilter.product:
        return _saleService.getByProduct(
          _filterId!, 
          pageNumber: page,
          pageSize: _pageSize,
        );
      case SaleFilter.service:
        return _saleService.getByService(
          _filterId!,
          pageNumber: page,
          pageSize: _pageSize,
        );
      case SaleFilter.dateRange:
        return _saleService.getByDateRange(
          startDate: _startDate!,
          endDate: _endDate!,
          pageNumber: page,
          pageSize: _pageSize,
        );
      case SaleFilter.none:
        return _saleService.getAll(pageNumber: page, pageSize: _pageSize);
    }
  }

  Future<void> filterByProduct(int productId) {
    _filter = SaleFilter.product;
    _filterId = productId;
    return fetchSales();
  }

  Future<void> filterByService(int serviceId) {
    _filter = SaleFilter.service;
    _filterId = serviceId;
    return fetchSales();
  }

  Future<void> filterByDateRange(DateTime start, DateTime end) {
    _filter = SaleFilter.dateRange;
    _startDate = start;
    _endDate = end;
    return fetchSales();
  }

  Future<void> clearFilter() {
    _filter = SaleFilter.none;
    _filterId = null;
    _startDate = null;
    _endDate = null;
    return fetchSales();
  }

  Future<void> fetchSaleDetail(int saleId) async {
    _detailStatus = ViewStatusSale.loading;
    _detailErrorMessage = null;
    _selectedSale = null;
    notifyListeners();

    try {
      _selectedSale = await _saleService.getById(saleId);
      _detailStatus = ViewStatusSale.success;
    } on ServerException catch (e) {
      _detailErrorMessage =
          e.statusCode == 404 ? 'Venta no encontrada' : e.message;
      _detailStatus = ViewStatusSale.error;
    } on AppException catch (e) {
      _detailErrorMessage = e.message;
      _detailStatus = ViewStatusSale.error;
    } on FormatException catch (e) {
      _detailErrorMessage = e.message;
      _detailStatus = ViewStatusSale.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH SALE DETAIL: $e');
      debugPrint('$stack');
      _detailErrorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _detailStatus = ViewStatusSale.error;
    }

    notifyListeners();
  }

  void clearDetail() {
    _selectedSale = null;
    _detailStatus = ViewStatusSale.initial;
    _detailErrorMessage = null;
    notifyListeners();
  }
}