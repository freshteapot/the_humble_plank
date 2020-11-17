part of openapi.api;

class AlistDataV1 {
  
  List<String> data = [];
  AlistDataV1();

  @override
  String toString() {
    return 'AlistDataV1[data=$data, ]';
  }

  AlistDataV1.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    data = (json['data'] == null) ?
      null :
      (json['data'] as List).cast<String>();
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (data != null)
      json['data'] = data;
    return json;
  }

  static List<AlistDataV1> listFromJson(List<dynamic> json) {
    return json == null ? List<AlistDataV1>() : json.map((value) => AlistDataV1.fromJson(value)).toList();
  }

  static Map<String, AlistDataV1> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AlistDataV1>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AlistDataV1.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AlistDataV1-objects as value to a dart map
  static Map<String, List<AlistDataV1>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AlistDataV1>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AlistDataV1.listFromJson(value);
       });
     }
     return map;
  }
}

