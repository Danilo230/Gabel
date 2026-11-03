import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/current_user_model.dart';
import 'package:gabel/services/authentication_service.dart';

enum ViewStatusProfile { initial, loading, success, error }

class ProfileProvider extends ChangeNotifier {
  final AuthenticationService _authenticationService;
  ProfileProvider(this._authenticationService);

  CurrentUserModel? _user;
  CurrentUserModel? get user => _user;

  ViewStatusProfile _viewStatus = ViewStatusProfile.initial;
  ViewStatusProfile get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProfile() async {
    if (_viewStatus == ViewStatusProfile.loading) return;

    _viewStatus = ViewStatusProfile.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _authenticationService.getCurrentUser();
      _viewStatus = ViewStatusProfile.success;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatusProfile.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH PROFILE: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _viewStatus = ViewStatusProfile.error;
    }

    notifyListeners();
  }

  Future<void> refresh() => fetchProfile();

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  String? _saveError;
  String? get saveError => _saveError;

  /// Devuelve true si se guardó bien.
  Future<bool> saveProfile({
    required String userName,
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
  }) async {
    if (_isSaving) return false;

    _isSaving = true;
    _saveError = null;
    notifyListeners();

    var ok = false;
    try {
      _user = await _authenticationService.updateProfile(
        userName: userName,
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      ok = true;
    } on AppException catch (e) {
      _saveError = e.message;
    } on FormatException catch (e) {
      _saveError = e.message;
    } catch (e, stack) {
      debugPrint('ERROR SAVE PROFILE: $e');
      debugPrint('$stack');
      _saveError = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
    }

    _isSaving = false;
    notifyListeners();
    return ok;
  }

  void clearSaveError() {
    _saveError = null;
  }
}