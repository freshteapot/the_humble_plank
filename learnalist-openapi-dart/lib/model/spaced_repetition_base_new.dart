part of openapi.api;

class SpacedRepetitionBaseNew {
  
  String show_ = null;
  
  String kind = null;
  SpacedRepetitionBaseNew();

  @override
  String toString() {
    return 'SpacedRepetitionBaseNew[show_=$show_, kind=$kind, ]';
  }

  SpacedRepetitionBaseNew.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    show_ = json['show'];
    kind = json['kind'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (show_ != null)
      json['show'] = show_;
    if (kind != null)
      json['kind'] = kind;
    return json;
  }

  static List<SpacedRepetitionBaseNew> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionBaseNew>() : json.map((value) => SpacedRepetitionBaseNew.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionBaseNew> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionBaseNew>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionBaseNew.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionBaseNew-objects as value to a dart map
  static Map<String, List<SpacedRepetitionBaseNew>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionBaseNew>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionBaseNew.listFromJson(value);
       });
     }
     return map;
  }
}

