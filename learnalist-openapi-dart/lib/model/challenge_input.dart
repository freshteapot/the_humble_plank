part of openapi.api;

class ChallengeInput {
  
  String kind = null;
  //enum kindEnum {  plank-group,  };{
  
  String description = null;
  ChallengeInput();

  @override
  String toString() {
    return 'ChallengeInput[kind=$kind, description=$description, ]';
  }

  ChallengeInput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    kind = json['kind'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (kind != null)
      json['kind'] = kind;
    if (description != null)
      json['description'] = description;
    return json;
  }

  static List<ChallengeInput> listFromJson(List<dynamic> json) {
    return json == null ? List<ChallengeInput>() : json.map((value) => ChallengeInput.fromJson(value)).toList();
  }

  static Map<String, ChallengeInput> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ChallengeInput>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ChallengeInput.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ChallengeInput-objects as value to a dart map
  static Map<String, List<ChallengeInput>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ChallengeInput>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ChallengeInput.listFromJson(value);
       });
     }
     return map;
  }
}

