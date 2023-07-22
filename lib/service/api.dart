import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const _apiTimeOutDuration = 15;
class APIServices {
  static Future<dynamic> getDataWithResponseApi({
    BuildContext? context,
    required String url,
    required void Function(Map<String, dynamic>?) successResponse,
    void Function(dynamic)? errorResponse,
  }) async {
    final Map<String, String> headers = {
      "Accept": "application/json"
    };
    try {
      final Uri uri = Uri.parse(url);
      final response = await http
          .get(
            uri,
            headers: headers,
          )
          .timeout(
            const Duration(seconds: _apiTimeOutDuration),
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? parsed = json.decode(response.body);
        return successResponse(parsed);
      } else if (response.statusCode == 422) {
        final parse = json.decode(response.body);
        return errorResponse!({'errorType': parse['errors']});
      } else if (response.statusCode == 404) {
        return errorResponse!({'errorType': 'Request Not Found'});
      } else if (response.statusCode == 405) {
        return errorResponse!({'errorType': 'Method Not Allowed'});
      } else if (response.statusCode == 500) {
        return errorResponse!({'errorType': 'Internal Server Error'});
      } else if (response.statusCode == 502) {
        return errorResponse!({'errorType': 'Temporary Services Down'});
      } else if (response.statusCode == 501) {
        return errorResponse!({'errorType': 'Not Implemented'});
      } else if (response.statusCode == 403) {
        return errorResponse!({'errorType': 'Please download later'});
      } else if (response.statusCode == 401) {
        return errorResponse!(
          {'errorType': 'Email or password is incorrect'},
        );
      } else if (response.statusCode == 400) {
        return errorResponse!({'errorType': 'Bad Request'});
      } else {
        return errorResponse!({'errorType': 'Something went wrong!'});
      }
    } on TimeoutException catch (_) {
      return errorResponse!({'errorType': 'Time Out'});
    } on SocketException catch (_) {
      return errorResponse!({
        'errorType': 'Check your internet connection or pull down to refresh.',
      });
    }
  }
}
