import 'BaseNetwork.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> login(Map<String, dynamic> inputBody) {
    return BaseNetwork.login("user/login", inputBody);
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> inputBody) {
    return BaseNetwork.register("user/register", inputBody);
  }

  Future<Map<String, dynamic>> logout(Map<String, dynamic> inputBody) {
    return BaseNetwork.logout("user/logout", inputBody);
  }
}
