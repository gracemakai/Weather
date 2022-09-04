import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class BaseService {
  var postRequestType = "POST";
  var getRequestType = "GET";
  var patchRequestType = "PUT";
  var deleteRequestType = "DELETE";

  databaseRequest(String link, String type,
      {Map<String, dynamic>? body,
        Map<String, String>? bodyFields,
        Map<String, String>? headers}) async {
    try {

      headers ??= {
        "Accept": "*/*",
        "Connection": "keep-alive",
      };

      var request = http.Request(type, Uri.parse(link));

      if (bodyFields != null) {
        request.bodyFields = bodyFields;
      }

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode != 200) {
        return null;
      } else {
        return response.stream.bytesToString();
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("Error on api $link $e $s");
      }
    }
  }
}