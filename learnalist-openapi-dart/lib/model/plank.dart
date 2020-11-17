part of openapi.api;

class Plank {
  
  String uuid = null;
  
  bool showIntervals = null;
  
  int intervalTime = null;
  
  int beginningTime = null;
  
  int currentTime = null;
  
  int timerNow = null;
  
  int intervalTimerNow = null;
  
  int laps = null;
  Plank();

  @override
  String toString() {
    return 'Plank[uuid=$uuid, showIntervals=$showIntervals, intervalTime=$intervalTime, beginningTime=$beginningTime, currentTime=$currentTime, timerNow=$timerNow, intervalTimerNow=$intervalTimerNow, laps=$laps, ]';
  }

  Plank.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    uuid = json['uuid'];
    showIntervals = json['showIntervals'];
    intervalTime = json['intervalTime'];
    beginningTime = json['beginningTime'];
    currentTime = json['currentTime'];
    timerNow = json['timerNow'];
    intervalTimerNow = json['intervalTimerNow'];
    laps = json['laps'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (uuid != null)
      json['uuid'] = uuid;
    if (showIntervals != null)
      json['showIntervals'] = showIntervals;
    if (intervalTime != null)
      json['intervalTime'] = intervalTime;
    if (beginningTime != null)
      json['beginningTime'] = beginningTime;
    if (currentTime != null)
      json['currentTime'] = currentTime;
    if (timerNow != null)
      json['timerNow'] = timerNow;
    if (intervalTimerNow != null)
      json['intervalTimerNow'] = intervalTimerNow;
    if (laps != null)
      json['laps'] = laps;
    return json;
  }

  static List<Plank> listFromJson(List<dynamic> json) {
    return json == null ? List<Plank>() : json.map((value) => Plank.fromJson(value)).toList();
  }

  static Map<String, Plank> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, Plank>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = Plank.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of Plank-objects as value to a dart map
  static Map<String, List<Plank>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<Plank>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = Plank.listFromJson(value);
       });
     }
     return map;
  }
}

