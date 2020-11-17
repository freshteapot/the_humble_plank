part of openapi.api;

class AlistInfo {
  
  String title = null;
  
  String type = null;
  
  List<String> labels = [];
  
  String sharedWith = null;
  
  AlistInteract interact = null;
  
  AlistFrom from = null;
  AlistInfo();

  @override
  String toString() {
    return 'AlistInfo[title=$title, type=$type, labels=$labels, sharedWith=$sharedWith, interact=$interact, from=$from, ]';
  }

  AlistInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title = json['title'];
    type = json['type'];
    labels = (json['labels'] == null) ?
      null :
      (json['labels'] as List).cast<String>();
    sharedWith = json['shared_with'];
    interact = (json['interact'] == null) ?
      null :
      AlistInteract.fromJson(json['interact']);
    from = (json['from'] == null) ?
      null :
      AlistFrom.fromJson(json['from']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (title != null)
      json['title'] = title;
    if (type != null)
      json['type'] = type;
    if (labels != null)
      json['labels'] = labels;
    if (sharedWith != null)
      json['shared_with'] = sharedWith;
    if (interact != null)
      json['interact'] = interact;
    if (from != null)
      json['from'] = from;
    return json;
  }

  static List<AlistInfo> listFromJson(List<dynamic> json) {
    return json == null ? List<AlistInfo>() : json.map((value) => AlistInfo.fromJson(value)).toList();
  }

  static Map<String, AlistInfo> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AlistInfo>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AlistInfo.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AlistInfo-objects as value to a dart map
  static Map<String, List<AlistInfo>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AlistInfo>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AlistInfo.listFromJson(value);
       });
     }
     return map;
  }
}

