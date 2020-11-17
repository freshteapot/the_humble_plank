part of openapi.api;

class SpacedRepetitionV1NewAllOf {
  
  String data = null;
  
  SpacedRepetitionBaseSettings settings = null;
  SpacedRepetitionV1NewAllOf();

  @override
  String toString() {
    return 'SpacedRepetitionV1NewAllOf[data=$data, settings=$settings, ]';
  }

  SpacedRepetitionV1NewAllOf.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    data = json['data'];
    settings = (json['settings'] == null) ?
      null :
      SpacedRepetitionBaseSettings.fromJson(json['settings']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (data != null)
      json['data'] = data;
    if (settings != null)
      json['settings'] = settings;
    return json;
  }

  static List<SpacedRepetitionV1NewAllOf> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionV1NewAllOf>() : json.map((value) => SpacedRepetitionV1NewAllOf.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionV1NewAllOf> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionV1NewAllOf>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionV1NewAllOf.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionV1NewAllOf-objects as value to a dart map
  static Map<String, List<SpacedRepetitionV1NewAllOf>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionV1NewAllOf>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionV1NewAllOf.listFromJson(value);
       });
     }
     return map;
  }
}

