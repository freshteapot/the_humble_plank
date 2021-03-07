part of openapi.api;

class SpacedRepetitionOvertimeInputBase {
  
  String alistUuid = null;
  
  String userUuid = null;
  SpacedRepetitionOvertimeInputBase();

  @override
  String toString() {
    return 'SpacedRepetitionOvertimeInputBase[alistUuid=$alistUuid, userUuid=$userUuid, ]';
  }

  SpacedRepetitionOvertimeInputBase.fromJson(Map<String, dynamic> json) {
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

  static List<SpacedRepetitionOvertimeInputBase> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionOvertimeInputBase>() : json.map((value) => SpacedRepetitionOvertimeInputBase.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionOvertimeInputBase> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionOvertimeInputBase>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionOvertimeInputBase.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionOvertimeInputBase-objects as value to a dart map
  static Map<String, List<SpacedRepetitionOvertimeInputBase>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionOvertimeInputBase>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionOvertimeInputBase.listFromJson(value);
       });
     }
     return map;
  }
}

