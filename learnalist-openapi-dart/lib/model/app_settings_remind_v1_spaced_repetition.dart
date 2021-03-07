part of openapi.api;

class AppSettingsRemindV1SpacedRepetition {
  /* Enable push notifications */
  int pushEnabled = null;
  AppSettingsRemindV1SpacedRepetition();

  @override
  String toString() {
    return 'AppSettingsRemindV1SpacedRepetition[pushEnabled=$pushEnabled, ]';
  }

  AppSettingsRemindV1SpacedRepetition.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pushEnabled = json['push_enabled'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (pushEnabled != null)
      json['push_enabled'] = pushEnabled;
    return json;
  }

  static List<AppSettingsRemindV1SpacedRepetition> listFromJson(List<dynamic> json) {
    return json == null ? List<AppSettingsRemindV1SpacedRepetition>() : json.map((value) => AppSettingsRemindV1SpacedRepetition.fromJson(value)).toList();
  }

  static Map<String, AppSettingsRemindV1SpacedRepetition> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AppSettingsRemindV1SpacedRepetition>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AppSettingsRemindV1SpacedRepetition.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AppSettingsRemindV1SpacedRepetition-objects as value to a dart map
  static Map<String, List<AppSettingsRemindV1SpacedRepetition>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AppSettingsRemindV1SpacedRepetition>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AppSettingsRemindV1SpacedRepetition.listFromJson(value);
       });
     }
     return map;
  }
}

