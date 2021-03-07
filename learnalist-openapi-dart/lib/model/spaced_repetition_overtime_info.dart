part of openapi.api;

class SpacedRepetitionOvertimeInfo {
  
  String dripfeedUuid = null;
  
  String alistUuid = null;
  
  String userUuid = null;
  SpacedRepetitionOvertimeInfo();

  @override
  String toString() {
    return 'SpacedRepetitionOvertimeInfo[dripfeedUuid=$dripfeedUuid, alistUuid=$alistUuid, userUuid=$userUuid, ]';
  }

  SpacedRepetitionOvertimeInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    dripfeedUuid = json['dripfeed_uuid'];
    alistUuid = json['alist_uuid'];
    userUuid = json['user_uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (dripfeedUuid != null)
      json['dripfeed_uuid'] = dripfeedUuid;
    if (alistUuid != null)
      json['alist_uuid'] = alistUuid;
    if (userUuid != null)
      json['user_uuid'] = userUuid;
    return json;
  }

  static List<SpacedRepetitionOvertimeInfo> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionOvertimeInfo>() : json.map((value) => SpacedRepetitionOvertimeInfo.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionOvertimeInfo> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionOvertimeInfo>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionOvertimeInfo.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionOvertimeInfo-objects as value to a dart map
  static Map<String, List<SpacedRepetitionOvertimeInfo>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionOvertimeInfo>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionOvertimeInfo.listFromJson(value);
       });
     }
     return map;
  }
}

