part of openapi.api;

class AnyType {
  AnyType();

  @override
  String toString() {
    return 'AnyType[]';
  }

  AnyType.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    return json;
  }

  static List<AnyType> listFromJson(List<dynamic> json) {
    return json == null ? List<AnyType>() : json.map((value) => AnyType.fromJson(value)).toList();
  }

  static Map<String, AnyType> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AnyType>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AnyType.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AnyType-objects as value to a dart map
  static Map<String, List<AnyType>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AnyType>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AnyType.listFromJson(value);
       });
     }
     return map;
  }
}

