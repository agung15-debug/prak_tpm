import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static final String apiKey = "398fab40cd8ca33280e873a230c3223f";

  static final String baseUrl = "https://api.musixmatch.com/ws/1.1";

  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = '$baseUrl/$partUrl&apikey=$apiKey';

    final response = await http.get(Uri.parse(fullUrl),
        headers: {"Access-Control-Allow-Origin": "*", 'Accept': '*/*'});

    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      print("processResponse error");
      return {"error": true};
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}
