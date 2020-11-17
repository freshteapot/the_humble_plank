part of openapi.api;

class ChallengePlankRecord {
  
  String uuid = null;
  
  bool showIntervals = null;
  
  int intervalTime = null;
  
  int beginningTime = null;
  
  int currentTime = null;
  
  int timerNow = null;
  
  int intervalTimerNow = null;
  
  int laps = null;
  /* User uuid */
  String userUuid = null;
  ChallengePlankRecord();

  @override
  String toString() {
    return 'ChallengePlankRecord[uuid=$uuid, showIntervals=$showIntervals, intervalTime=$intervalTime, beginningTime=$beginningTime, currentTime=$currentTime, timerNow=$timerNow, intervalTimerNow=$intervalTimerNow, laps=$laps, userUuid=$userUuid, ]';
  }

  ChallengePlankRecord.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    uuid = json['uuid'];
    showIntervals = json['showIntervals'];
    intervalTime = json['intervalTime'];
    beginningTime = json['beginningTime'];
    currentTime = json['currentTime'];
    timerNow = json['timerNow'];
    intervalTimerNow = json['intervalTimerNow'];
    laps = json['laps'];
    userUuid = json['user_uuid'];
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
    if (userUuid != null)
      json['user_uuid'] = userUuid;
    return json;
  }

  static List<ChallengePlankRecord> listFromJson(List<dynamic> json) {
    return json == null ? List<ChallengePlankRecord>() : json.map((value) => ChallengePlankRecord.fromJson(value)).toList();
  }

  static Map<String, ChallengePlankRecord> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ChallengePlankRecord>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ChallengePlankRecord.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ChallengePlankRecord-objects as value to a dart map
  static Map<String, List<ChallengePlankRecord>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ChallengePlankRecord>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ChallengePlankRecord.listFromJson(value);
       });
     }
     return map;
  }
}

