import 'dart:convert';

import 'package:gabel/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TokenRepository {
  final SharedPreferencesAsync _sharedPreferences = SharedPreferencesAsync();
  final String _tokenKey = 'auth_token';

  Future<void> saveToken(TokenModel token) async{
    final String jsonString = jsonEncode(token.toJson());
    await _sharedPreferences.setString(_tokenKey, jsonString);
  }

  Future<TokenModel?>getToken() async{
    final String? rawJson = await _sharedPreferences.getString(_tokenKey);
    if (rawJson == null) return null;
    
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(rawJson);
      return TokenModel.fromJson(jsonMap);
    } catch (e) {
      await removeToken(); // Remove the invalid token from storage
    }

    return null;
  }

  Future<void> removeToken() async{
    await _sharedPreferences.remove(_tokenKey);
  }

  Future<bool> hasValidToken() async => await getToken() != null;
  
}