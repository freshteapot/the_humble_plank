part of openapi.api;

class SpacedRepetitionV2NewAllOf {
  
  SpacedRepetitionDataV2 data = null;
  
  SpacedRepetitionSettingsV2 settings = null;
  SpacedRepetitionV2NewAllOf();

  @override
  String toString() {
    return 'SpacedRepetitionV2NewAllOf[data=$data, settings=$settings, ]';
  }

  SpacedRepetitionV2NewAllOf.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    data = (json['data'] == null) ?
      null :
      SpacedRepetitionDataV2.fromJson(json['data']);
    settings = (json['settings'] == null) ?
      null :
      SpacedRepetitionSettingsV2.fromJson(json['settings']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (data != null)
      json['data'] = data;
    if (settings != null)
      json['settings'] = settings;
    return json;
  }

  static List<SpacedRepetitionV2NewAllOf> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionV2NewAllOf>() : json.map((value) => SpacedRepetitionV2NewAllOf.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionV2NewAllOf> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionV2NewAllOf>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionV2NewAllOf.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionV2NewAllOf-objects as value to a dart map
  static Map<String, List<SpacedRepetitionV2NewAllOf>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionV2NewAllOf>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionV2NewAllOf.listFromJson(value);
       });
     }
     return map;
  }
}

