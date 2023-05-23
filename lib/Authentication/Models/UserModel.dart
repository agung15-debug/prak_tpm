class Model {
  final String? message;
  final Data data;

  Model({required this.message, required this.data});

  Model.fromJson(Map<String, dynamic> json)
      : message = json["message"] as String?,
        data = Data.fromJson(json["data"]);
}

class Data {
  final User user;
  final String accessToken;

  Data({required this.user, required this.accessToken});

  Data.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        accessToken = (json['accessToken'] as String);
}

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  User.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        email = json["email"];
}
