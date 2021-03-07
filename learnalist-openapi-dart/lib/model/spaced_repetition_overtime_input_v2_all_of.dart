part of openapi.api;

class SpacedRepetitionOvertimeInputV2AllOf {
  
  SpacedRepetitionOvertimeInputV2AllOfSettings settings = null;
  SpacedRepetitionOvertimeInputV2AllOf();

  @override
  String toString() {
    return 'SpacedRepetitionOvertimeInputV2AllOf[settings=$settings, ]';
  }

  SpacedRepetitionOvertimeInputV2AllOf.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    settings = (json['settings'] == null) ?
      null :
      SpacedRepetitionOvertimeInputV2AllOfSettings.fromJson(json['settings']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (settings != null)
      json['settings'] = settings;
    return json;
  }

  static List<SpacedRepetitionOvertimeInputV2AllOf> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionOvertimeInputV2AllOf>() : json.map((value) => SpacedRepetitionOvertimeInputV2AllOf.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionOvertimeInputV2AllOf> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionOvertimeInputV2AllOf>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionOvertimeInputV2AllOf.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionOvertimeInputV2AllOf-objects as value to a dart map
  static Map<String, List<SpacedRepetitionOvertimeInputV2AllOf>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionOvertimeInputV2AllOf>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionOvertimeInputV2AllOf.listFromJson(value);
       });
     }
     return map;
  }
}

