part of openapi.api;

class SpacedRepetitionBaseSettings {
  
  String level = null;
  /* Set to UTC */
  DateTime whenNext = null;
  /* Set to UTC */
  DateTime created = null;
  SpacedRepetitionBaseSettings();

  @override
  String toString() {
    return 'SpacedRepetitionBaseSettings[level=$level, whenNext=$whenNext, created=$created, ]';
  }

  SpacedRepetitionBaseSettings.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
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
    if (level != null)
      json['level'] = level;
    if (whenNext != null)
      json['when_next'] = whenNext == null ? null : whenNext.toUtc().toIso8601String();
    if (created != null)
      json['created'] = created == null ? null : created.toUtc().toIso8601String();
    return json;
  }

  static List<SpacedRepetitionBaseSettings> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionBaseSettings>() : json.map((value) => SpacedRepetitionBaseSettings.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionBaseSettings> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionBaseSettings>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionBaseSettings.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionBaseSettings-objects as value to a dart map
  static Map<String, List<SpacedRepetitionBaseSettings>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionBaseSettings>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionBaseSettings.listFromJson(value);
       });
     }
     return map;
  }
}

