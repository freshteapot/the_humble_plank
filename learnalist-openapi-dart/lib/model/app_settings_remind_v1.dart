part of openapi.api;

class AppSettingsRemindV1 {
  
  AppSettingsRemindV1SpacedRepetition spacedRepetition = null;
  AppSettingsRemindV1();

  @override
  String toString() {
    return 'AppSettingsRemindV1[spacedRepetition=$spacedRepetition, ]';
  }

  AppSettingsRemindV1.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    spacedRepetition = (json['spaced_repetition'] == null) ?
      null :
      AppSettingsRemindV1SpacedRepetition.fromJson(json['spaced_repetition']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (spacedRepetition != null)
      json['spaced_repetition'] = spacedRepetition;
    return json;
  }

  static List<AppSettingsRemindV1> listFromJson(List<dynamic> json) {
    return json == null ? List<AppSettingsRemindV1>() : json.map((value) => AppSettingsRemindV1.fromJson(value)).toList();
  }

  static Map<String, AppSettingsRemindV1> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AppSettingsRemindV1>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AppSettingsRemindV1.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AppSettingsRemindV1-objects as value to a dart map
  static Map<String, List<AppSettingsRemindV1>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AppSettingsRemindV1>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AppSettingsRemindV1.listFromJson(value);
       });
     }
     return map;
  }
}

