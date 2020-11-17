part of openapi.api;

class Version {
  
  String gitHash = null;
  
  String gitDate = null;
  
  String version = null;
  
  String url = null;
  Version();

  @override
  String toString() {
    return 'Version[gitHash=$gitHash, gitDate=$gitDate, version=$version, url=$url, ]';
  }

  Version.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    gitHash = json['gitHash'];
    gitDate = json['gitDate'];
    version = json['version'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (gitHash != null)
      json['gitHash'] = gitHash;
    if (gitDate != null)
      json['gitDate'] = gitDate;
    if (version != null)
      json['version'] = version;
    if (url != null)
      json['url'] = url;
    return json;
  }

  static List<Version> listFromJson(List<dynamic> json) {
    return json == null ? List<Version>() : json.map((value) => Version.fromJson(value)).toList();
  }

  static Map<String, Version> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, Version>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = Version.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of Version-objects as value to a dart map
  static Map<String, List<Version>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<Version>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = Version.listFromJson(value);
       });
     }
     return map;
  }
}

