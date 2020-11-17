part of openapi.api;

class ChallengeInfoAllOf {
  /* List of users */
  List<ChallengeInfoAllOfUsers> users = [];
  /* List of records, specific to the kind */
  List<ChallengePlankRecord> records = [];
  ChallengeInfoAllOf();

  @override
  String toString() {
    return 'ChallengeInfoAllOf[users=$users, records=$records, ]';
  }

  ChallengeInfoAllOf.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    users = (json['users'] == null) ?
      null :
      ChallengeInfoAllOfUsers.listFromJson(json['users']);
    records = (json['records'] == null) ?
      null :
      ChallengePlankRecord.listFromJson(json['records']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (users != null)
      json['users'] = users;
    if (records != null)
      json['records'] = records;
    return json;
  }

  static List<ChallengeInfoAllOf> listFromJson(List<dynamic> json) {
    return json == null ? List<ChallengeInfoAllOf>() : json.map((value) => ChallengeInfoAllOf.fromJson(value)).toList();
  }

  static Map<String, ChallengeInfoAllOf> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ChallengeInfoAllOf>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ChallengeInfoAllOf.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ChallengeInfoAllOf-objects as value to a dart map
  static Map<String, List<ChallengeInfoAllOf>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ChallengeInfoAllOf>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ChallengeInfoAllOf.listFromJson(value);
       });
     }
     return map;
  }
}

