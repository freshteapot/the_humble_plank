part of openapi.api;

class HttpUserRegisterResponse {
  
  String username = null;
  
  String uuid = null;
  HttpUserRegisterResponse();

  @override
  String toString() {
    return 'HttpUserRegisterResponse[username=$username, uuid=$uuid, ]';
  }

  HttpUserRegisterResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    username = json['username'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (username != null)
      json['username'] = username;
    if (uuid != null)
      json['uuid'] = uuid;
    return json;
  }

  static List<HttpUserRegisterResponse> listFromJson(List<dynamic> json) {
    return json == null ? List<HttpUserRegisterResponse>() : json.map((value) => HttpUserRegisterResponse.fromJson(value)).toList();
  }

  static Map<String, HttpUserRegisterResponse> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, HttpUserRegisterResponse>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = HttpUserRegisterResponse.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpUserRegisterResponse-objects as value to a dart map
  static Map<String, List<HttpUserRegisterResponse>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<HttpUserRegisterResponse>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = HttpUserRegisterResponse.listFromJson(value);
       });
     }
     return map;
  }
}

