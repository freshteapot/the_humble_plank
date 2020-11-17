part of openapi.api;

class AlistAllOf {
  
  String uuid = null;
  AlistAllOf();

  @override
  String toString() {
    return 'AlistAllOf[uuid=$uuid, ]';
  }

  AlistAllOf.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (uuid != null)
      json['uuid'] = uuid;
    return json;
  }

  static List<AlistAllOf> listFromJson(List<dynamic> json) {
    return json == null ? List<AlistAllOf>() : json.map((value) => AlistAllOf.fromJson(value)).toList();
  }

  static Map<String, AlistAllOf> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AlistAllOf>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AlistAllOf.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AlistAllOf-objects as value to a dart map
  static Map<String, List<AlistAllOf>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AlistAllOf>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AlistAllOf.listFromJson(value);
       });
     }
     return map;
  }
}

