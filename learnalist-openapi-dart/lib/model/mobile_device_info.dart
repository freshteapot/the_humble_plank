part of openapi.api;

class MobileDeviceInfo {
  
  String userUuid = null;
  /* FCM token linked to the device */
  String token = "";
  /* A unique identifier to allow the system to link a user with an app and use the correct token. */
  String appIdentifier = "";
  //enum appIdentifierEnum {  plank_v1,  remind_v1,  };{
  MobileDeviceInfo();

  @override
  String toString() {
    return 'MobileDeviceInfo[userUuid=$userUuid, token=$token, appIdentifier=$appIdentifier, ]';
  }

  MobileDeviceInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userUuid = json['user_uuid'];
    token = json['token'];
    appIdentifier = json['app_identifier'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userUuid != null)
      json['user_uuid'] = userUuid;
    if (token != null)
      json['token'] = token;
    if (appIdentifier != null)
      json['app_identifier'] = appIdentifier;
    return json;
  }

  static List<MobileDeviceInfo> listFromJson(List<dynamic> json) {
    return json == null ? List<MobileDeviceInfo>() : json.map((value) => MobileDeviceInfo.fromJson(value)).toList();
  }

  static Map<String, MobileDeviceInfo> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, MobileDeviceInfo>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = MobileDeviceInfo.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of MobileDeviceInfo-objects as value to a dart map
  static Map<String, List<MobileDeviceInfo>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<MobileDeviceInfo>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = MobileDeviceInfo.listFromJson(value);
       });
     }
     return map;
  }
}

