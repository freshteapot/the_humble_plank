part of openapi.api;

class SpacedRepetitionV1 {
  
  String show_ = null;
  
  String kind = null;
  
  String data = null;
  
  SpacedRepetitionBaseSettings settings = null;
  
  String uuid = null;
  SpacedRepetitionV1();

  @override
  String toString() {
    return 'SpacedRepetitionV1[show_=$show_, kind=$kind, data=$data, settings=$settings, uuid=$uuid, ]';
  }

  SpacedRepetitionV1.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    show_ = json['show'];
    kind = json['kind'];
    data = json['data'];
    settings = (json['settings'] == null) ?
      null :
      SpacedRepetitionBaseSettings.fromJson(json['settings']);
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

  static List<SpacedRepetitionV1> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionV1>() : json.map((value) => SpacedRepetitionV1.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionV1> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionV1>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionV1.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionV1-objects as value to a dart map
  static Map<String, List<SpacedRepetitionV1>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionV1>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionV1.listFromJson(value);
       });
     }
     return map;
  }
}

