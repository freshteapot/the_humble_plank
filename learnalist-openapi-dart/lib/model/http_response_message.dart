part of openapi.api;

class HttpResponseMessage {
  
  String message = null;
  HttpResponseMessage();

  @override
  String toString() {
    return 'HttpResponseMessage[message=$message, ]';
  }

  HttpResponseMessage.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (message != null)
      json['message'] = message;
    return json;
  }

  static List<HttpResponseMessage> listFromJson(List<dynamic> json) {
    return json == null ? List<HttpResponseMessage>() : json.map((value) => HttpResponseMessage.fromJson(value)).toList();
  }

  static Map<String, HttpResponseMessage> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, HttpResponseMessage>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = HttpResponseMessage.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpResponseMessage-objects as value to a dart map
  static Map<String, List<HttpResponseMessage>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<HttpResponseMessage>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = HttpResponseMessage.listFromJson(value);
       });
     }
     return map;
  }
}

