part of openapi.api;

class HttpAssetShareRequestBody {
  
  String uuid = null;
  
  String action = null;
  //enum actionEnum {  private,  public,  };{
  HttpAssetShareRequestBody();

  @override
  String toString() {
    return 'HttpAssetShareRequestBody[uuid=$uuid, action=$action, ]';
  }

  HttpAssetShareRequestBody.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    uuid = json['uuid'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (uuid != null)
      json['uuid'] = uuid;
    if (action != null)
      json['action'] = action;
    return json;
  }

  static List<HttpAssetShareRequestBody> listFromJson(List<dynamic> json) {
    return json == null ? List<HttpAssetShareRequestBody>() : json.map((value) => HttpAssetShareRequestBody.fromJson(value)).toList();
  }

  static Map<String, HttpAssetShareRequestBody> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, HttpAssetShareRequestBody>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = HttpAssetShareRequestBody.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpAssetShareRequestBody-objects as value to a dart map
  static Map<String, List<HttpAssetShareRequestBody>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<HttpAssetShareRequestBody>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = HttpAssetShareRequestBody.listFromJson(value);
       });
     }
     return map;
  }
}

