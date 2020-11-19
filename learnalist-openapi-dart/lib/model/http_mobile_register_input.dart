part of openapi.api;

class HttpMobileRegisterInput {
  /* FCM token linked to the device */
  String token = "";
  HttpMobileRegisterInput();

  @override
  String toString() {
    return 'HttpMobileRegisterInput[token=$token, ]';
  }

  HttpMobileRegisterInput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (token != null)
      json['token'] = token;
    return json;
  }

  static List<HttpMobileRegisterInput> listFromJson(List<dynamic> json) {
    return json == null ? List<HttpMobileRegisterInput>() : json.map((value) => HttpMobileRegisterInput.fromJson(value)).toList();
  }

  static Map<String, HttpMobileRegisterInput> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, HttpMobileRegisterInput>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = HttpMobileRegisterInput.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpMobileRegisterInput-objects as value to a dart map
  static Map<String, List<HttpMobileRegisterInput>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<HttpMobileRegisterInput>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = HttpMobileRegisterInput.listFromJson(value);
       });
     }
     return map;
  }
}

