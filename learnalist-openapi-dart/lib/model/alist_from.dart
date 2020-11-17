part of openapi.api;

class AlistFrom {
  /* Context of where it came from, when coming from quizlet, cram, brainscape, it is not possible to make the list public. */
  String kind = null;
  //enum kindEnum {  quizlet,  cram,  brainscape,  learnalist,  };{
  
  String extUuid = null;
  
  String refUrl = null;
  AlistFrom();

  @override
  String toString() {
    return 'AlistFrom[kind=$kind, extUuid=$extUuid, refUrl=$refUrl, ]';
  }

  AlistFrom.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    kind = json['kind'];
    extUuid = json['ext_uuid'];
    refUrl = json['ref_url'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (kind != null)
      json['kind'] = kind;
    if (extUuid != null)
      json['ext_uuid'] = extUuid;
    if (refUrl != null)
      json['ref_url'] = refUrl;
    return json;
  }

  static List<AlistFrom> listFromJson(List<dynamic> json) {
    return json == null ? List<AlistFrom>() : json.map((value) => AlistFrom.fromJson(value)).toList();
  }

  static Map<String, AlistFrom> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AlistFrom>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AlistFrom.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AlistFrom-objects as value to a dart map
  static Map<String, List<AlistFrom>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AlistFrom>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AlistFrom.listFromJson(value);
       });
     }
     return map;
  }
}

