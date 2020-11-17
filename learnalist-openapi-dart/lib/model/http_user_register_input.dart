part of openapi.api;

class HttpUserRegisterInput {
  
  String username = null;
  
  String password = null;
  
  HttpUserInfoInput extra = null;
  HttpUserRegisterInput();

  @override
  String toString() {
    return 'HttpUserRegisterInput[username=$username, password=$password, extra=$extra, ]';
  }

  HttpUserRegisterInput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    username = json['username'];
    password = json['password'];
    extra = (json['extra'] == null) ?
      null :
      HttpUserInfoInput.fromJson(json['extra']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (username != null)
      json['username'] = username;
    if (password != null)
      json['password'] = password;
    if (extra != null)
      json['extra'] = extra;
    return json;
  }

  static List<HttpUserRegisterInput> listFromJson(List<dynamic> json) {
    return json == null ? List<HttpUserRegisterInput>() : json.map((value) => HttpUserRegisterInput.fromJson(value)).toList();
  }

  static Map<String, HttpUserRegisterInput> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, HttpUserRegisterInput>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = HttpUserRegisterInput.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpUserRegisterInput-objects as value to a dart map
  static Map<String, List<HttpUserRegisterInput>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<HttpUserRegisterInput>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = HttpUserRegisterInput.listFromJson(value);
       });
     }
     return map;
  }
}

