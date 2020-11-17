part of openapi.api;

class ChallengeInfoAllOfUsers {
  /* User uuid */
  String userUuid = null;
  /* Name the user wants for this challenge */
  String name = null;
  ChallengeInfoAllOfUsers();

  @override
  String toString() {
    return 'ChallengeInfoAllOfUsers[userUuid=$userUuid, name=$name, ]';
  }

  ChallengeInfoAllOfUsers.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userUuid = json['user_uuid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userUuid != null)
      json['user_uuid'] = userUuid;
    if (name != null)
      json['name'] = name;
    return json;
  }

  static List<ChallengeInfoAllOfUsers> listFromJson(List<dynamic> json) {
    return json == null ? List<ChallengeInfoAllOfUsers>() : json.map((value) => ChallengeInfoAllOfUsers.fromJson(value)).toList();
  }

  static Map<String, ChallengeInfoAllOfUsers> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ChallengeInfoAllOfUsers>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ChallengeInfoAllOfUsers.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ChallengeInfoAllOfUsers-objects as value to a dart map
  static Map<String, List<ChallengeInfoAllOfUsers>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ChallengeInfoAllOfUsers>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ChallengeInfoAllOfUsers.listFromJson(value);
       });
     }
     return map;
  }
}

