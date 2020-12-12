part of openapi.api;

class ChallengeInfo {
  
  String kind = null;
  //enum kindEnum {  plank-group,  };{
  
  String description = null;
  /* Set to UTC */
  DateTime created = null;
  /* User who created the challenge */
  String createdBy = null;
  
  String uuid = null;
  /* List of users */
  List<ChallengeInfoAllOfUsers> users = [];
  /* List of records, specific to the kind */
  List<ChallengePlankRecord> records = [];
  ChallengeInfo();

  @override
  String toString() {
    return 'ChallengeInfo[kind=$kind, description=$description, created=$created, createdBy=$createdBy, uuid=$uuid, users=$users, records=$records, ]';
  }

  ChallengeInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    kind = json['kind'];
    description = json['description'];
    created = (json['created'] == null) ?
      null :
      DateTime.parse(json['created']);
    createdBy = json['created_by'];
    uuid = json['uuid'];
    users = (json['users'] == null) ?
      null :
      ChallengeInfoAllOfUsers.listFromJson(json['users']);
    records = (json['records'] == null) ?
      null :
      ChallengePlankRecord.listFromJson(json['records']);
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
    if (users != null)
      json['users'] = users;
    if (records != null)
      json['records'] = records;
    return json;
  }

  static List<ChallengeInfo> listFromJson(List<dynamic> json) {
    return json == null ? List<ChallengeInfo>() : json.map((value) => ChallengeInfo.fromJson(value)).toList();
  }

  static Map<String, ChallengeInfo> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ChallengeInfo>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ChallengeInfo.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ChallengeInfo-objects as value to a dart map
  static Map<String, List<ChallengeInfo>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ChallengeInfo>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ChallengeInfo.listFromJson(value);
       });
     }
     return map;
  }
}

