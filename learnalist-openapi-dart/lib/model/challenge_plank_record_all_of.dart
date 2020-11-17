part of openapi.api;

class ChallengePlankRecordAllOf {
  /* User uuid */
  String userUuid = null;
  ChallengePlankRecordAllOf();

  @override
  String toString() {
    return 'ChallengePlankRecordAllOf[userUuid=$userUuid, ]';
  }

  ChallengePlankRecordAllOf.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userUuid = json['user_uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userUuid != null)
      json['user_uuid'] = userUuid;
    return json;
  }

  static List<ChallengePlankRecordAllOf> listFromJson(List<dynamic> json) {
    return json == null ? List<ChallengePlankRecordAllOf>() : json.map((value) => ChallengePlankRecordAllOf.fromJson(value)).toList();
  }

  static Map<String, ChallengePlankRecordAllOf> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ChallengePlankRecordAllOf>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ChallengePlankRecordAllOf.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ChallengePlankRecordAllOf-objects as value to a dart map
  static Map<String, List<ChallengePlankRecordAllOf>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ChallengePlankRecordAllOf>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ChallengePlankRecordAllOf.listFromJson(value);
       });
     }
     return map;
  }
}

