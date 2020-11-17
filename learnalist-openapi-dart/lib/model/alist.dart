part of openapi.api;

class Alist {
  
  String uuid = null;
  
  AlistInfo info = null;
  
  AnyType data = null;
  Alist();

  @override
  String toString() {
    return 'Alist[uuid=$uuid, info=$info, data=$data, ]';
  }

  Alist.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    uuid = json['uuid'];
    info = (json['info'] == null) ?
      null :
      AlistInfo.fromJson(json['info']);
    data = (json['data'] == null) ?
      null :
      AnyType.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (uuid != null)
      json['uuid'] = uuid;
    if (info != null)
      json['info'] = info;
    if (data != null)
      json['data'] = data;
    return json;
  }

  static List<Alist> listFromJson(List<dynamic> json) {
    return json == null ? List<Alist>() : json.map((value) => Alist.fromJson(value)).toList();
  }

  static Map<String, Alist> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, Alist>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = Alist.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of Alist-objects as value to a dart map
  static Map<String, List<Alist>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<Alist>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = Alist.listFromJson(value);
       });
     }
     return map;
  }
}

