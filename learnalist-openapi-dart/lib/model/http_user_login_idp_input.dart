part of openapi.api;

class HttpUserLoginIDPInput {
  
  String idp = null;
  //enum idpEnum {  google,  };{
  /* We will verify this to confirm your identity and create an account linked to your id. */
  String idToken = null;
  /* We might use this to lookup your basic info. */
  String accessToken = null;
  HttpUserLoginIDPInput();

  @override
  String toString() {
    return 'HttpUserLoginIDPInput[idp=$idp, idToken=$idToken, accessToken=$accessToken, ]';
  }

  HttpUserLoginIDPInput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    idp = json['idp'];
    idToken = json['id_token'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (idp != null)
      json['idp'] = idp;
    if (idToken != null)
      json['id_token'] = idToken;
    if (accessToken != null)
      json['access_token'] = accessToken;
    return json;
  }

  static List<HttpUserLoginIDPInput> listFromJson(List<dynamic> json) {
    return json == null ? List<HttpUserLoginIDPInput>() : json.map((value) => HttpUserLoginIDPInput.fromJson(value)).toList();
  }

  static Map<String, HttpUserLoginIDPInput> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, HttpUserLoginIDPInput>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = HttpUserLoginIDPInput.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpUserLoginIDPInput-objects as value to a dart map
  static Map<String, List<HttpUserLoginIDPInput>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<HttpUserLoginIDPInput>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = HttpUserLoginIDPInput.listFromJson(value);
       });
     }
     return map;
  }
}

