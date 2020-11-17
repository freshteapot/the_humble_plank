part of openapi.api;

class SpacedRepetitionBase {
  
  String show_ = null;
  
  String kind = null;
  
  String uuid = null;
  SpacedRepetitionBase();

  @override
  String toString() {
    return 'SpacedRepetitionBase[show_=$show_, kind=$kind, uuid=$uuid, ]';
  }

  SpacedRepetitionBase.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    show_ = json['show'];
    kind = json['kind'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (show_ != null)
      json['show'] = show_;
    if (kind != null)
      json['kind'] = kind;
    if (uuid != null)
      json['uuid'] = uuid;
    return json;
  }

  static List<SpacedRepetitionBase> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionBase>() : json.map((value) => SpacedRepetitionBase.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionBase> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionBase>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionBase.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionBase-objects as value to a dart map
  static Map<String, List<SpacedRepetitionBase>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionBase>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionBase.listFromJson(value);
       });
     }
     return map;
  }
}

