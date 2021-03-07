part of openapi.api;

class SpacedRepetitionOvertimeInputV2AllOfSettings {
  
  String show_ = null;
  SpacedRepetitionOvertimeInputV2AllOfSettings();

  @override
  String toString() {
    return 'SpacedRepetitionOvertimeInputV2AllOfSettings[show_=$show_, ]';
  }

  SpacedRepetitionOvertimeInputV2AllOfSettings.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    show_ = json['show'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (show_ != null)
      json['show'] = show_;
    return json;
  }

  static List<SpacedRepetitionOvertimeInputV2AllOfSettings> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionOvertimeInputV2AllOfSettings>() : json.map((value) => SpacedRepetitionOvertimeInputV2AllOfSettings.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionOvertimeInputV2AllOfSettings> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionOvertimeInputV2AllOfSettings>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionOvertimeInputV2AllOfSettings.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionOvertimeInputV2AllOfSettings-objects as value to a dart map
  static Map<String, List<SpacedRepetitionOvertimeInputV2AllOfSettings>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionOvertimeInputV2AllOfSettings>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionOvertimeInputV2AllOfSettings.listFromJson(value);
       });
     }
     return map;
  }
}

