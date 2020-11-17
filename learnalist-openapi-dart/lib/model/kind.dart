part of openapi.api;

class Kind {
  
  String kind = null;
  Kind();

  @override
  String toString() {
    return 'Kind[kind=$kind, ]';
  }

  Kind.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    kind = json['kind'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (kind != null)
      json['kind'] = kind;
    return json;
  }

  static List<Kind> listFromJson(List<dynamic> json) {
    return json == null ? List<Kind>() : json.map((value) => Kind.fromJson(value)).toList();
  }

  static Map<String, Kind> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, Kind>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = Kind.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of Kind-objects as value to a dart map
  static Map<String, List<Kind>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<Kind>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = Kind.listFromJson(value);
       });
     }
     return map;
  }
}

