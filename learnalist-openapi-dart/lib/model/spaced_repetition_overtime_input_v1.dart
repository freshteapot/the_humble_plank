part of openapi.api;

class SpacedRepetitionOvertimeInputV1 {
  
  String alistUuid = null;
  
  String userUuid = null;
  SpacedRepetitionOvertimeInputV1();

  @override
  String toString() {
    return 'SpacedRepetitionOvertimeInputV1[alistUuid=$alistUuid, userUuid=$userUuid, ]';
  }

  SpacedRepetitionOvertimeInputV1.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    alistUuid = json['alist_uuid'];
    userUuid = json['user_uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (alistUuid != null)
      json['alist_uuid'] = alistUuid;
    if (userUuid != null)
      json['user_uuid'] = userUuid;
    return json;
  }

  static List<SpacedRepetitionOvertimeInputV1> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionOvertimeInputV1>() : json.map((value) => SpacedRepetitionOvertimeInputV1.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionOvertimeInputV1> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionOvertimeInputV1>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionOvertimeInputV1.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionOvertimeInputV1-objects as value to a dart map
  static Map<String, List<SpacedRepetitionOvertimeInputV1>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionOvertimeInputV1>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionOvertimeInputV1.listFromJson(value);
       });
     }
     return map;
  }
}

