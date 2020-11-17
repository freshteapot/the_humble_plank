part of openapi.api;

class SpacedRepetitionV1New {
  
  String show_ = null;
  
  String kind = null;
  
  String data = null;
  
  SpacedRepetitionBaseSettings settings = null;
  SpacedRepetitionV1New();

  @override
  String toString() {
    return 'SpacedRepetitionV1New[show_=$show_, kind=$kind, data=$data, settings=$settings, ]';
  }

  SpacedRepetitionV1New.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    show_ = json['show'];
    kind = json['kind'];
    data = json['data'];
    settings = (json['settings'] == null) ?
      null :
      SpacedRepetitionBaseSettings.fromJson(json['settings']);
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

  static List<SpacedRepetitionV1New> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionV1New>() : json.map((value) => SpacedRepetitionV1New.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionV1New> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionV1New>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionV1New.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionV1New-objects as value to a dart map
  static Map<String, List<SpacedRepetitionV1New>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionV1New>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionV1New.listFromJson(value);
       });
     }
     return map;
  }
}

