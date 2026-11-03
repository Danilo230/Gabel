import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/stylist_model.dart';
import 'package:gabel/presentation/providers/user_provider.dart' show ViewStatus;
import 'package:gabel/services/stylist_service.dart';

class StylistProvider extends ChangeNotifier {
  final StylistService _stylistService;
  StylistProvider(this._stylistService);

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  List<StylistModel> _stylists = [];
  List<StylistModel> get stylists => _stylists;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchStylists() async {
    if (_viewStatus == ViewStatus.loading) return;

    _viewStatus = ViewStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final all = await _stylistService.getAllPages();
      _stylists = all.where((stylist) => stylist.stylistStatus).toList();
      _viewStatus = ViewStatus.success;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH STYLISTS: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _viewStatus = ViewStatus.error;
    }

    notifyListeners();
  }
}
