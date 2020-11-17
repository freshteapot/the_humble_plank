part of openapi.api;

class SpacedRepetitionEntryViewed {
  
  String uuid = null;
  
  String action = null;
  SpacedRepetitionEntryViewed();

  @override
  String toString() {
    return 'SpacedRepetitionEntryViewed[uuid=$uuid, action=$action, ]';
  }

  SpacedRepetitionEntryViewed.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    uuid = json['uuid'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (uuid != null)
      json['uuid'] = uuid;
    if (action != null)
      json['action'] = action;
    return json;
  }

  static List<SpacedRepetitionEntryViewed> listFromJson(List<dynamic> json) {
    return json == null ? List<SpacedRepetitionEntryViewed>() : json.map((value) => SpacedRepetitionEntryViewed.fromJson(value)).toList();
  }

  static Map<String, SpacedRepetitionEntryViewed> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SpacedRepetitionEntryViewed>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SpacedRepetitionEntryViewed.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SpacedRepetitionEntryViewed-objects as value to a dart map
  static Map<String, List<SpacedRepetitionEntryViewed>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SpacedRepetitionEntryViewed>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SpacedRepetitionEntryViewed.listFromJson(value);
       });
     }
     return map;
  }
}

