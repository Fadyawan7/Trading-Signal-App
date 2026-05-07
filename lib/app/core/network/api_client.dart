import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../values/app_constants.dart';
import 'api_exception.dart';

class ApiClient {
  ApiClient({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(AppNetworkConstants.baseUrl).resolve(endpoint);
    final requestBody = body ?? <String, dynamic>{};

    _logRequest(method: 'POST', uri: uri, body: requestBody);

    http.Response response;
    try {
      response = await _httpClient
          .post(
            uri,
            headers:
                const {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                  }.map((key, value) => MapEntry(key, value))
                  ..addAll(headers ?? const <String, String>{}),
            body: jsonEncode(requestBody),
          )
          .timeout(AppNetworkConstants.requestTimeout);
    } on http.ClientException catch (error) {
      _logFailure(method: 'POST', uri: uri, error: error.toString());
      throw ApiException('Unable to connect to server. Please try again.');
    } catch (error) {
      _logFailure(method: 'POST', uri: uri, error: error.toString());
      throw ApiException('Request failed. Please try again.');
    }

    return _parseResponse(method: 'POST', uri: uri, response: response);
  }

  Map<String, dynamic> _parseResponse({
    required String method,
    required Uri uri,
    required http.Response response,
  }) {
    Map<String, dynamic> payload = <String, dynamic>{};

    if (response.body.isNotEmpty) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        payload = decoded;
      }
    }

    _logResponse(
      method: method,
      uri: uri,
      statusCode: response.statusCode,
      payload: payload,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return payload;
    }

    final message = payload['message']?.toString();
    throw ApiException(
      message == null || message.isEmpty
          ? 'Something went wrong. Please try again.'
          : message,
      statusCode: response.statusCode,
    );
  }

  void _logRequest({
    required String method,
    required Uri uri,
    required Map<String, dynamic> body,
  }) {
    debugPrint(
      '[API REQUEST] $method $uri\n'
      'Body: ${jsonEncode(_sanitize(body))}',
    );
  }

  void _logResponse({
    required String method,
    required Uri uri,
    required int statusCode,
    required Map<String, dynamic> payload,
  }) {
    debugPrint(
      '[API RESPONSE] $method $uri\n'
      'Status Code: $statusCode\n'
      'Body: ${jsonEncode(_sanitize(payload))}',
    );
  }

  void _logFailure({
    required String method,
    required Uri uri,
    required String error,
  }) {
    debugPrint(
      '[API ERROR] $method $uri\n'
      'Error: $error',
    );
  }

  Map<String, dynamic> _sanitize(Map<String, dynamic> body) {
    return body.map((key, value) {
      final normalizedKey = key.toLowerCase();
      final isSensitive =
          normalizedKey.contains('password') ||
          normalizedKey.contains('token') ||
          normalizedKey.contains('otp');

      return MapEntry(key, isSensitive ? '******' : _sanitizeValue(value));
    });
  }

  dynamic _sanitizeValue(dynamic value) {
    if (value is Map<String, dynamic>) {
      return _sanitize(value);
    }
    if (value is List) {
      return value.map(_sanitizeValue).toList();
    }
    return value;
  }
}
