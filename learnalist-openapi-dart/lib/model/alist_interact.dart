part of openapi.api;

class AlistInteract {
  
  int slideshow = null;
  
  int totalrecall = null;
  AlistInteract();

  @override
  String toString() {
    return 'AlistInteract[slideshow=$slideshow, totalrecall=$totalrecall, ]';
  }

  AlistInteract.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    slideshow = json['slideshow'];
    totalrecall = json['totalrecall'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (slideshow != null)
      json['slideshow'] = slideshow;
    if (totalrecall != null)
      json['totalrecall'] = totalrecall;
    return json;
  }

  static List<AlistInteract> listFromJson(List<dynamic> json) {
    return json == null ? List<AlistInteract>() : json.map((value) => AlistInteract.fromJson(value)).toList();
  }

  static Map<String, AlistInteract> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AlistInteract>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AlistInteract.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AlistInteract-objects as value to a dart map
  static Map<String, List<AlistInteract>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AlistInteract>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AlistInteract.listFromJson(value);
       });
     }
     return map;
  }
}

