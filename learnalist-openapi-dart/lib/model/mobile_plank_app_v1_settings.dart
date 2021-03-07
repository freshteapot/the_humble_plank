part of openapi.api;

class MobilePlankAppV1Settings {
  
  bool showIntervals = null;
  
  int intervalTime = null;
  MobilePlankAppV1Settings();

  @override
  String toString() {
    return 'MobilePlankAppV1Settings[showIntervals=$showIntervals, intervalTime=$intervalTime, ]';
  }

  MobilePlankAppV1Settings.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    showIntervals = json['showIntervals'];
    intervalTime = json['intervalTime'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (showIntervals != null)
      json['showIntervals'] = showIntervals;
    if (intervalTime != null)
      json['intervalTime'] = intervalTime;
    return json;
  }

  static List<MobilePlankAppV1Settings> listFromJson(List<dynamic> json) {
    return json == null ? List<MobilePlankAppV1Settings>() : json.map((value) => MobilePlankAppV1Settings.fromJson(value)).toList();
  }

  static Map<String, MobilePlankAppV1Settings> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, MobilePlankAppV1Settings>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = MobilePlankAppV1Settings.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of MobilePlankAppV1Settings-objects as value to a dart map
  static Map<String, List<MobilePlankAppV1Settings>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<MobilePlankAppV1Settings>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = MobilePlankAppV1Settings.listFromJson(value);
       });
     }
     return map;
  }
}

