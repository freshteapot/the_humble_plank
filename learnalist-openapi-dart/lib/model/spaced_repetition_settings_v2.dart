part of openapi.api;

class SpacedRepetitionSettingsV2 {
  
  String show_ = null;
  
  String level = null;
  /* Set to UTC */
  DateTime whenNext = null;
  /* Set to UTC */
  DateTime created = null;
  SpacedRepetitionSettingsV2();

  @override
  String toString() {
    return 'SpacedRepetitionSettingsV2[show_=$show_, level=$level, whenNext=$whenNext, created=$created, ]';
  }

  SpacedRepetitionSettingsV2.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    show_ = json['show'];
    level = json['level'];
    whenNext = (json['when_next'] == null) ?
      null :
      DateTime.parse(json['when_next']);
    created = (json['created'] == null) ?
      null :
      DateTime.parse(json['created']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (show_ != null)
      json['show'] = show_;
    if (level != null)
      json['level'] = level;
    if (whenNext != null)
      json['when_next'] = whenNext == null ? null : whenNext.toUtc().toIso8601String();
    if (created != null)
      json['created'] = created == null ? null : created.toUtc().toIso8601String();
    return json;
  }

  static List<SpacedRepetitionSettingsV2> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionSettingsV2>() : json.map((value) => SpacedRepetitionSettingsV2.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionSettingsV2> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionSettingsV2>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionSettingsV2.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionSettingsV2-objects as value to a dart map
  static Map<String, List<SpacedRepetitionSettingsV2>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionSettingsV2>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionSettingsV2.listFromJson(value);
       });
     }
     return map;
  }
}

