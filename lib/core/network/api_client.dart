import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/token_model.dart';
import 'package:http/http.dart' as http;
import 'package:gabel/core/constants/api_constants.dart';

typedef AuthTokenProvider = Future<TokenModel?> Function();

class ApiClient {
  final AuthTokenProvider? _authTokenProvider;
  ApiClient({this._authTokenProvider});

  final http.Client _client = http.Client();

  Future<dynamic> get(String path, {Map<String, String>? query}) async => _send('GET', path, query, null);
  Future<dynamic> post(String path, {Object? body}) async => _send('POST', path, null, body);
  Future<dynamic> put(String path, {Object? body}) async => _send('PUT', path, null, body);
  Future<dynamic> delete(String path) async => _send('DELETE', path, null, null);

  Future<dynamic> _send(String method, String path, Map <String, String>? query, Object? body) async {
    final baseUrl = ApiConstants.instance.baseUrl;
    // Url base: https://localhost:7284/api
    // path: /Auth/Login
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    final Map<String, String> headers = {};
    if (body != null) {
      headers['Content-Type'] = 'application/json';
    }

    TokenModel? token = await _authTokenProvider?.call();
    if (token != null) {
      headers['Authorization'] = 'Bearer ${token.token}';
    }

    final request = http.Request(method, uri)..headers.addAll(headers);
    if (body != null) {
      request.body = jsonEncode(body);
    }

    final http.Response response;
    try {
      response = await _client.send(request)
        .timeout(ApiConstants.timeoutDuration)
        .then(http.Response.fromStream);
    } on TimeoutException{
      throw NetworkException('Request timed out. Please check your internet connection and try again.');
    } on http.ClientException catch (e) {
        debugPrint('ClientException: $e');   // import 'package:flutter/foundation.dart';
        debugPrint('URL: $uri');
      throw const NetworkException('Failed to send request. Please try again later.');
    } 

    if (response.statusCode ==401) {
      throw const UnauthorizedException();
    }

    return _decode(response);
  }

  dynamic _decode(http.Response response) {

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ServerException('Request failed', statusCode: response.statusCode);
    }

    if (response.body.isEmpty) return null;

    try {
      return jsonDecode(response.body);
    } on FormatException {
      throw const ParsingException();
    }
  }

  void dispose() => _client.close();
}