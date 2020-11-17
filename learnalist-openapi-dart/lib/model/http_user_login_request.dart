part of openapi.api;

class HttpUserLoginRequest {
  
  String username = null;
  
  String password = null;
  
  HttpUserInfoInput extra = null;
  HttpUserLoginRequest();

  @override
  String toString() {
    return 'HttpUserLoginRequest[username=$username, password=$password, extra=$extra, ]';
  }

  HttpUserLoginRequest.fromJson(Map<String, dynamic> json) {
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

  static List<HttpUserLoginRequest> listFromJson(List<dynamic> json) {
    return json == null ? List<HttpUserLoginRequest>() : json.map((value) => HttpUserLoginRequest.fromJson(value)).toList();
  }

  static Map<String, HttpUserLoginRequest> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, HttpUserLoginRequest>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = HttpUserLoginRequest.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpUserLoginRequest-objects as value to a dart map
  static Map<String, List<HttpUserLoginRequest>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<HttpUserLoginRequest>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = HttpUserLoginRequest.listFromJson(value);
       });
     }
     return map;
  }
}

