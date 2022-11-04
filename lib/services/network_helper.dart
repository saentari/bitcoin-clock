import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  Future fetchData(String uri, [Map<String, String>? header]) async {
    if (kDebugMode) print('connecting to $uri, with header $header');
    var url = Uri.parse(uri);
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      if (kDebugMode) print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
