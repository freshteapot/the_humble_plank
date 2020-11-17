part of openapi.api;

class SpacedRepetitionBaseSettingsShow {
  
  String show_ = null;
  SpacedRepetitionBaseSettingsShow();

  @override
  String toString() {
    return 'SpacedRepetitionBaseSettingsShow[show_=$show_, ]';
  }

  SpacedRepetitionBaseSettingsShow.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    show_ = json['show'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (show_ != null)
      json['show'] = show_;
    return json;
  }

  static List<SpacedRepetitionBaseSettingsShow> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionBaseSettingsShow>() : json.map((value) => SpacedRepetitionBaseSettingsShow.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionBaseSettingsShow> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionBaseSettingsShow>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionBaseSettingsShow.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionBaseSettingsShow-objects as value to a dart map
  static Map<String, List<SpacedRepetitionBaseSettingsShow>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionBaseSettingsShow>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionBaseSettingsShow.listFromJson(value);
       });
     }
     return map;
  }
}

