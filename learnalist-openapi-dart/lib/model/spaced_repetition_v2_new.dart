part of openapi.api;

class SpacedRepetitionV2New {
  
  String show_ = null;
  
  String kind = null;
  
  SpacedRepetitionDataV2 data = null;
  
  SpacedRepetitionSettingsV2 settings = null;
  SpacedRepetitionV2New();

  @override
  String toString() {
    return 'SpacedRepetitionV2New[show_=$show_, kind=$kind, data=$data, settings=$settings, ]';
  }

  SpacedRepetitionV2New.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    show_ = json['show'];
    kind = json['kind'];
    data = (json['data'] == null) ?
      null :
      SpacedRepetitionDataV2.fromJson(json['data']);
    settings = (json['settings'] == null) ?
      null :
      SpacedRepetitionSettingsV2.fromJson(json['settings']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (show_ != null)
      json['show'] = show_;
    if (kind != null)
      json['kind'] = kind;
    if (data != null)
      json['data'] = data;
    if (settings != null)
      json['settings'] = settings;
    return json;
  }

  static List<SpacedRepetitionV2New> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionV2New>() : json.map((value) => SpacedRepetitionV2New.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionV2New> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionV2New>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionV2New.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionV2New-objects as value to a dart map
  static Map<String, List<SpacedRepetitionV2New>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionV2New>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionV2New.listFromJson(value);
       });
     }
     return map;
  }
}

