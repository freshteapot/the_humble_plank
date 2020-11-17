part of openapi.api;

class SpacedRepetitionDataV2 {
  
  String from = null;
  
  String to = null;
  SpacedRepetitionDataV2();

  @override
  String toString() {
    return 'SpacedRepetitionDataV2[from=$from, to=$to, ]';
  }

  SpacedRepetitionDataV2.fromJson(Map<String, dynamic> json) {
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

  static List<SpacedRepetitionDataV2> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionDataV2>() : json.map((value) => SpacedRepetitionDataV2.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionDataV2> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionDataV2>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionDataV2.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionDataV2-objects as value to a dart map
  static Map<String, List<SpacedRepetitionDataV2>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionDataV2>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionDataV2.listFromJson(value);
       });
     }
     return map;
  }
}

