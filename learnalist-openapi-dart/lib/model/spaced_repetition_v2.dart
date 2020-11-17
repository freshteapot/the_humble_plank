part of openapi.api;

class SpacedRepetitionV2 {
  
  String show_ = null;
  
  String kind = null;
  
  SpacedRepetitionDataV2 data = null;
  
  SpacedRepetitionSettingsV2 settings = null;
  
  String uuid = null;
  SpacedRepetitionV2();

  @override
  String toString() {
    return 'SpacedRepetitionV2[show_=$show_, kind=$kind, data=$data, settings=$settings, uuid=$uuid, ]';
  }

  SpacedRepetitionV2.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    show_ = json['show'];
    kind = json['kind'];
    data = (json['data'] == null) ?
      null :
      SpacedRepetitionDataV2.fromJson(json['data']);
    settings = (json['settings'] == null) ?
      null :
      SpacedRepetitionSettingsV2.fromJson(json['settings']);
    uuid = json['uuid'];
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
    if (uuid != null)
      json['uuid'] = uuid;
    return json;
  }

  static List<SpacedRepetitionV2> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionV2>() : json.map((value) => SpacedRepetitionV2.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionV2> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionV2>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionV2.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionV2-objects as value to a dart map
  static Map<String, List<SpacedRepetitionV2>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionV2>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionV2.listFromJson(value);
       });
     }
     return map;
  }
}

