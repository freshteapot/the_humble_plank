part of openapi.api;

class AlistDataV2 {
  
  List<AlistItemV2> data = [];
  AlistDataV2();

  @override
  String toString() {
    return 'AlistDataV2[data=$data, ]';
  }

  AlistDataV2.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    data = (json['data'] == null) ?
      null :
      AlistItemV2.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (data != null)
      json['data'] = data;
    return json;
  }

  static List<AlistDataV2> listFromJson(List<dynamic> json) {
    return json == null ? List<AlistDataV2>() : json.map((value) => AlistDataV2.fromJson(value)).toList();
  }

  static Map<String, AlistDataV2> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AlistDataV2>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AlistDataV2.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AlistDataV2-objects as value to a dart map
  static Map<String, List<AlistDataV2>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AlistDataV2>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AlistDataV2.listFromJson(value);
       });
     }
     return map;
  }
}

