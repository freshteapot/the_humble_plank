part of openapi.api;

class HttpMobileRegisterInput {
  /* FCM token linked to the device */
  String token = "";
  /* A unique identifier to allow the system to link a user with an app and use the correct token. */
  String appIdentifier = "";
  //enum appIdentifierEnum {  plank_v1,  remind_v1,  };{
  HttpMobileRegisterInput();

  @override
  String toString() {
    return 'HttpMobileRegisterInput[token=$token, appIdentifier=$appIdentifier, ]';
  }

  HttpMobileRegisterInput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    token = json['token'];
    appIdentifier = json['app_identifier'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (token != null)
      json['token'] = token;
    if (appIdentifier != null)
      json['app_identifier'] = appIdentifier;
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

