part of openapi.api;

class HttpUserInfoInput {
  /* Does the user want push_notifications. */
  bool plankPushNotifications = false;
  /* This will be used to address you in the app(s) or website. */
  String displayName = "";
  /* Let the server know the user was created via the plank app. */
  String createdVia = "";
  //enum createdViaEnum {  plank.app.v1,  };{
  HttpUserInfoInput();

  @override
  String toString() {
    return 'HttpUserInfoInput[plankPushNotifications=$plankPushNotifications, displayName=$displayName, createdVia=$createdVia, ]';
  }

  HttpUserInfoInput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    plankPushNotifications = json['plank_push_notifications'];
    displayName = json['display_name'];
    createdVia = json['created_via'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (plankPushNotifications != null)
      json['plank_push_notifications'] = plankPushNotifications;
    if (displayName != null)
      json['display_name'] = displayName;
    if (createdVia != null)
      json['created_via'] = createdVia;
    return json;
  }

  static List<HttpUserInfoInput> listFromJson(List<dynamic> json) {
    return json == null ? List<HttpUserInfoInput>() : json.map((value) => HttpUserInfoInput.fromJson(value)).toList();
  }

  static Map<String, HttpUserInfoInput> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, HttpUserInfoInput>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = HttpUserInfoInput.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpUserInfoInput-objects as value to a dart map
  static Map<String, List<HttpUserInfoInput>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<HttpUserInfoInput>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = HttpUserInfoInput.listFromJson(value);
       });
     }
     return map;
  }
}

