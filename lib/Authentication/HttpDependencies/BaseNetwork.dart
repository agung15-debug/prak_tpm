import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  // static final String baseUrl = "https://express-crud-cj3ez54bpa-et.a.run.app/";
  static final String baseUrl = "http://localhost:3005";

  static Future<Map<String, dynamic>> login(
      String partUrl, Map<String, dynamic> reqBody) async {
    final String fullUrl = baseUrl + "/" + partUrl;

    final response = await http.post(Uri.parse(fullUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": reqBody["email"],
          "password": reqBody["password"],
        }));

    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> register(
      String partUrl, Map<String, dynamic> reqBody) async {
    final String fullUrl = baseUrl + "/" + partUrl;

    final response = await http.post(Uri.parse(fullUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": reqBody["email"],
          "password": reqBody["password"],
          "username": reqBody["username"]
        }));

    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> logout(
      String partUrl, Map<String, dynamic> reqBody) async {
    final String fullUrl = baseUrl + "/" + partUrl;

    final response =
        await http.post(Uri.parse(fullUrl), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + reqBody['accessToken'],
    });

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
