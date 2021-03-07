part of openapi.api;

class RemindDailySettings {
  /* Time of day HH:MM */
  String timeOfDay = "";
  /* Timezone */
  String tz = "";
  /* Which app to link this too */
  String appIdentifier = "";
  /* Which medium, look at RemindMedium */
  List<String> medium = [];
  RemindDailySettings();

  @override
  String toString() {
    return 'RemindDailySettings[timeOfDay=$timeOfDay, tz=$tz, appIdentifier=$appIdentifier, medium=$medium, ]';
  }

  RemindDailySettings.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    timeOfDay = json['time_of_day'];
    tz = json['tz'];
    appIdentifier = json['app_identifier'];
    medium = (json['medium'] == null) ?
      null :
      (json['medium'] as List).cast<String>();
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (timeOfDay != null)
      json['time_of_day'] = timeOfDay;
    if (tz != null)
      json['tz'] = tz;
    if (appIdentifier != null)
      json['app_identifier'] = appIdentifier;
    if (medium != null)
      json['medium'] = medium;
    return json;
  }

  static List<RemindDailySettings> listFromJson(List<dynamic> json) {
    return json == null ? List<RemindDailySettings>() : json.map((value) => RemindDailySettings.fromJson(value)).toList();
  }

  static Map<String, RemindDailySettings> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, RemindDailySettings>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = RemindDailySettings.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of RemindDailySettings-objects as value to a dart map
  static Map<String, List<RemindDailySettings>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<RemindDailySettings>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = RemindDailySettings.listFromJson(value);
       });
     }
     return map;
  }
}

