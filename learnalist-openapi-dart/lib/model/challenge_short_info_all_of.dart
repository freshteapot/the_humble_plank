part of openapi.api;

class ChallengeShortInfoAllOf {
  /* Set to UTC */
  DateTime created = null;
  /* User who created the challenge */
  String createdBy = null;
  
  String uuid = null;
  ChallengeShortInfoAllOf();

  @override
  String toString() {
    return 'ChallengeShortInfoAllOf[created=$created, createdBy=$createdBy, uuid=$uuid, ]';
  }

  ChallengeShortInfoAllOf.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    created = (json['created'] == null) ?
      null :
      DateTime.parse(json['created']);
    createdBy = json['created_by'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (created != null)
      json['created'] = created == null ? null : created.toUtc().toIso8601String();
    if (createdBy != null)
      json['created_by'] = createdBy;
    if (uuid != null)
      json['uuid'] = uuid;
    return json;
  }

  static List<ChallengeShortInfoAllOf> listFromJson(List<dynamic> json) {
    return json == null ? List<ChallengeShortInfoAllOf>() : json.map((value) => ChallengeShortInfoAllOf.fromJson(value)).toList();
  }

  static Map<String, ChallengeShortInfoAllOf> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ChallengeShortInfoAllOf>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ChallengeShortInfoAllOf.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ChallengeShortInfoAllOf-objects as value to a dart map
  static Map<String, List<ChallengeShortInfoAllOf>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ChallengeShortInfoAllOf>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ChallengeShortInfoAllOf.listFromJson(value);
       });
     }
     return map;
  }
}

