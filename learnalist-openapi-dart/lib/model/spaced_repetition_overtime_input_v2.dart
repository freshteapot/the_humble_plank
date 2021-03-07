part of openapi.api;

class SpacedRepetitionOvertimeInputV2 {
  
  SpacedRepetitionOvertimeInputV2AllOfSettings settings = null;
  
  String alistUuid = null;
  
  String userUuid = null;
  SpacedRepetitionOvertimeInputV2();

  @override
  String toString() {
    return 'SpacedRepetitionOvertimeInputV2[settings=$settings, alistUuid=$alistUuid, userUuid=$userUuid, ]';
  }

  SpacedRepetitionOvertimeInputV2.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    settings = (json['settings'] == null) ?
      null :
      SpacedRepetitionOvertimeInputV2AllOfSettings.fromJson(json['settings']);
    alistUuid = json['alist_uuid'];
    userUuid = json['user_uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (settings != null)
      json['settings'] = settings;
    if (alistUuid != null)
      json['alist_uuid'] = alistUuid;
    if (userUuid != null)
      json['user_uuid'] = userUuid;
    return json;
  }

  static List<SpacedRepetitionOvertimeInputV2> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionOvertimeInputV2>() : json.map((value) => SpacedRepetitionOvertimeInputV2.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionOvertimeInputV2> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionOvertimeInputV2>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionOvertimeInputV2.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionOvertimeInputV2-objects as value to a dart map
  static Map<String, List<SpacedRepetitionOvertimeInputV2>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionOvertimeInputV2>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionOvertimeInputV2.listFromJson(value);
       });
     }
     return map;
  }
}

