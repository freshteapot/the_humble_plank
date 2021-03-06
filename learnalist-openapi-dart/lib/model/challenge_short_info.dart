part of openapi.api;

class ChallengeShortInfo {
  /* Look at ChallengeKind for supported kinds */
  String kind = "";
  
  String description = "";
  /* Set to UTC */
  DateTime created = null;
  /* User who created the challenge */
  String createdBy = null;
  
  String uuid = null;
  ChallengeShortInfo();

  @override
  String toString() {
    return 'ChallengeShortInfo[kind=$kind, description=$description, created=$created, createdBy=$createdBy, uuid=$uuid, ]';
  }

  ChallengeShortInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    kind = json['kind'];
    description = json['description'];
    created = (json['created'] == null) ?
      null :
      DateTime.parse(json['created']);
    createdBy = json['created_by'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (kind != null)
      json['kind'] = kind;
    if (description != null)
      json['description'] = description;
    if (created != null)
      json['created'] = created == null ? null : created.toUtc().toIso8601String();
    if (createdBy != null)
      json['created_by'] = createdBy;
    if (uuid != null)
      json['uuid'] = uuid;
    return json;
  }

  static List<ChallengeShortInfo> listFromJson(List<dynamic> json) {
    return json == null ? List<ChallengeShortInfo>() : json.map((value) => ChallengeShortInfo.fromJson(value)).toList();
  }

  static Map<String, ChallengeShortInfo> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ChallengeShortInfo>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ChallengeShortInfo.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ChallengeShortInfo-objects as value to a dart map
  static Map<String, List<ChallengeShortInfo>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ChallengeShortInfo>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ChallengeShortInfo.listFromJson(value);
       });
     }
     return map;
  }
}

