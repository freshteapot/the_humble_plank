part of openapi.api;

class HttpUserLoginResponse {
  
  String token = null;
  
  String userUuid = null;
  HttpUserLoginResponse();

  @override
  String toString() {
    return 'HttpUserLoginResponse[token=$token, userUuid=$userUuid, ]';
  }

  HttpUserLoginResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    token = json['token'];
    userUuid = json['user_uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (token != null)
      json['token'] = token;
    if (userUuid != null)
      json['user_uuid'] = userUuid;
    return json;
  }

  static List<HttpUserLoginResponse> listFromJson(List<dynamic> json) {
    return json == null ? List<HttpUserLoginResponse>() : json.map((value) => HttpUserLoginResponse.fromJson(value)).toList();
  }

  static Map<String, HttpUserLoginResponse> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, HttpUserLoginResponse>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = HttpUserLoginResponse.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpUserLoginResponse-objects as value to a dart map
  static Map<String, List<HttpUserLoginResponse>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<HttpUserLoginResponse>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = HttpUserLoginResponse.listFromJson(value);
       });
     }
     return map;
  }
}

