part of openapi.api;

class MobileDeviceInfoAllOf {
  
  String userUuid = null;
  MobileDeviceInfoAllOf();

  @override
  String toString() {
    return 'MobileDeviceInfoAllOf[userUuid=$userUuid, ]';
  }

  MobileDeviceInfoAllOf.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userUuid = json['user_uuid'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userUuid != null)
      json['user_uuid'] = userUuid;
    return json;
  }

  static List<MobileDeviceInfoAllOf> listFromJson(List<dynamic> json) {
    return json == null ? List<MobileDeviceInfoAllOf>() : json.map((value) => MobileDeviceInfoAllOf.fromJson(value)).toList();
  }

  static Map<String, MobileDeviceInfoAllOf> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, MobileDeviceInfoAllOf>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = MobileDeviceInfoAllOf.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of MobileDeviceInfoAllOf-objects as value to a dart map
  static Map<String, List<MobileDeviceInfoAllOf>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<MobileDeviceInfoAllOf>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = MobileDeviceInfoAllOf.listFromJson(value);
       });
     }
     return map;
  }
}

