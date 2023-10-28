import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../domain/either/either.dart';

part 'failure.dart';
part 'logs.dart';
part 'parse_response_body.dart';

enum HttpMethod { get, post, patch, delete, put }

class Http {
  Http({
    Client? client,
    required String baseUrl,
    String? apiKey,
    Map<String, dynamic>? headersGeneral,
  })  : _client = client ?? Client(),
        _apiKey = apiKey ?? '',
        _baseUrl = baseUrl,
        _headersGeneral = headersGeneral ?? {};

  final Client _client;
  final String _baseUrl;
  final String _apiKey;
  final Map<String, dynamic> _headersGeneral;

  Future<Either<HttpFailure, T>> request<T>(
    String path, {
    required T Function(dynamic responseBody) onSuccess,
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    bool useApiKey = false,
    String titleUseApiKey = 'api_key',
    Map<String, dynamic> body = const {},
    Duration timeout = const Duration(seconds: 35),
  }) async {
    Map<String, dynamic> logs = {};
    StackTrace? stackTrace;
    try {
      if (useApiKey) {
        queryParameters = {
          ...queryParameters,
          titleUseApiKey: _apiKey,
        };
      }

      Uri url = Uri.parse(
        path.startsWith('http') ? path : '$_baseUrl$path',
      );
      if (queryParameters.isNotEmpty) {
        url = url.replace(
          queryParameters: queryParameters,
        );
      }

      headers = {
        'Content-Type': 'application/json',
        ...headers,
        ..._headersGeneral,
      };
      late final Response response;
      final bodyString = jsonEncode(body);
      logs = {
        'url': url.toString(),
        'method': method.name,
        'body': body,
        'header': headers,
      };
      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url).timeout(timeout);
          break;
        case HttpMethod.post:
          response = await _client
              .post(
                url,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
          break;
        case HttpMethod.patch:
          response = await _client
              .patch(
                url,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
          break;
        case HttpMethod.delete:
          response = await _client
              .delete(
                url,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
          break;
        case HttpMethod.put:
          response = await _client
              .put(
                url,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
          break;
      }

      final statusCode = response.statusCode;

      final responseBody = _parseResponseBody(response.body);

      logs = {
        ...logs,
        'startTime': DateTime.now().toIso8601String(),
        'statusCode': statusCode,
        'resposeBody': responseBody
      };

      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(
          onSuccess(
            responseBody,
          ),
        );
      }

      return Either.left(
        HttpFailure(
          statusCode: statusCode,
          data: responseBody,
        ),
      );
    } catch (e, s) {
      stackTrace = s;
      logs = {
        ...logs,
        'exception': e.toString(),
        // 'exceptionType': e.runtimeType,
      };

      if (e is SocketException || e is ClientException) {
        logs = {
          ...logs,
          'exception': 'NetworkException',
        };
        return Either.left(
          HttpFailure(
            exception: NetworkException(),
          ),
        );
      }

      return Either.left(
        HttpFailure(
          exception: e,
        ),
      );
    } finally {
      logs = {
        ...logs,
        'endTime': DateTime.now().toIso8601String(),
      };

      if (kDebugMode) _printLogs(logs, stackTrace);
    }
  }
}
