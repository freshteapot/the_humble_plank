part of openapi.api;

class AlistItemV2 {
  
  String from = null;
  
  String to = null;
  AlistItemV2();

  @override
  String toString() {
    return 'AlistItemV2[from=$from, to=$to, ]';
  }

  AlistItemV2.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (from != null)
      json['from'] = from;
    if (to != null)
      json['to'] = to;
    return json;
  }

  static List<AlistItemV2> listFromJson(List<dynamic> json) {
    return json == null ? List<AlistItemV2>() : json.map((value) => AlistItemV2.fromJson(value)).toList();
  }

  static Map<String, AlistItemV2> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AlistItemV2>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AlistItemV2.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AlistItemV2-objects as value to a dart map
  static Map<String, List<AlistItemV2>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AlistItemV2>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AlistItemV2.listFromJson(value);
       });
     }
     return map;
  }
}

